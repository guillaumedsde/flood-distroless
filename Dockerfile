ARG BUILD_DATE
ARG VCS_REF
ARG FLOOD_VERSION=master

FROM node:14-buster-slim as build

ARG FLOOD_VERSION

WORKDIR /flood

# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get install -y --no-install-recommends  \
    git \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/jesec/flood.git . \
    && git checkout "${FLOOD_VERSION}"

RUN npm install

RUN npm run build

WORKDIR /rootfs

ARG BUSYBOX_VERSION=1.31.0-i686-uclibc
ADD https://busybox.net/downloads/binaries/$BUSYBOX_VERSION/busybox_WGET /rootfs/wget
RUN chmod a+x /rootfs/wget

WORKDIR /rootfs/flood

RUN mv /flood/dist/* ./ \
    && mv /flood/package*.json ./

RUN npm install --only=production

FROM gcr.io/distroless/nodejs:14

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG FLOOD_VERSION

LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="flood-distroless" \
    org.label-schema.description="Distroless container for the Flood program" \
    org.label-schema.url="https://guillaumedsde.gitlab.io/flood-distroless/" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.version=$FLOOD_VERSION \
    org.label-schema.vcs-url="https://github.com/guillaumedsde/flood-distroless" \
    org.label-schema.vendor="guillaumedsde" \
    org.label-schema.schema-version="1.0"

COPY --from=build --chown=1000:1000 /rootfs /

EXPOSE 3000

VOLUME /data

USER 1000

# Flood
ENTRYPOINT ["/nodejs/bin/node", "--use_strict", "/flood/index.js", "--host=0.0.0.0", "--rundir=/data"]

HEALTHCHECK  --start-period=15s --interval=30s --timeout=5s --retries=5 \
    CMD [ "/wget", "--quiet", "--tries=1", "--spider", "http://localhost:3000/"]