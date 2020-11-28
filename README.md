# [🐋 Flood-distroless](https://github.com/guillaumedsde/flood-distroless)

[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/guillaumedsde/flood-distroless)](https://hub.docker.com/r/guillaumedsde/flood-distroless/builds)
[![Gitlab pipeline status](https://img.shields.io/gitlab/pipeline/guillaumedsde/flood-distroless?label=documentation)](https://guillaumedsde.gitlab.io/flood-distroless/)
[![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/guillaumedsde/flood-distroless)](https://hub.docker.com/r/guillaumedsde/flood-distroless/builds)
[![Docker Image Version (latest by date)](https://img.shields.io/docker/v/guillaumedsde/flood-distroless)](https://hub.docker.com/r/guillaumedsde/flood-distroless/tags)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/guillaumedsde/flood-distroless)](https://hub.docker.com/r/guillaumedsde/flood-distroless)
[![Docker Pulls](https://img.shields.io/docker/pulls/guillaumedsde/flood-distroless)](https://hub.docker.com/r/guillaumedsde/flood-distroless)
[![GitHub stars](https://img.shields.io/github/stars/guillaumedsde/flood-distroless?label=Github%20stars)](https://github.com/guillaumedsde/flood-distroless)
[![GitHub watchers](https://img.shields.io/github/watchers/guillaumedsde/flood-distroless?label=Github%20Watchers)](https://github.com/guillaumedsde/flood-distroless)
[![Docker Stars](https://img.shields.io/docker/stars/guillaumedsde/flood-distroless)](https://hub.docker.com/r/guillaumedsde/flood-distroless)
[![GitHub](https://img.shields.io/github/license/guillaumedsde/flood-distroless)](https://github.com/guillaumedsde/flood-distroless/blob/master/LICENSE.md)

This repository contains the code to build a small and secure **[distroless](https://github.com/GoogleContainerTools/distroless)** **docker** image for **[Flood](https://github.com/jesec/flood)** running as an unprivileged user.
The final images are built and hosted on the [dockerhub](https://hub.docker.com/r/guillaumedsde/flood-distroless) and the documentation is hosted on [gitlab pages](https://guillaumedsde.gitlab.io/flood-distroless/)

## ✔️ Features summary

- 🥑 [distroless](https://github.com/GoogleContainerTools/distroless) minimal image
- 🤏 As few Docker layers as possible
- 🛡️ only basic runtime dependencies
- 🛡️ Runs as unprivileged user with minimal permissions

## 🏁 How to Run

### `docker run`

```bash
$ docker run  -v /your/data/path/:/data \
              -v /etc/localtime:/etc/localtime:ro \
              -p 3000:3000 \
              --read-only \
              --user 1000:1000 \
              guillaumedsde/flood-distroless:latest
```

#### `docker-compose.yml`

```yaml
version: "3.3"
services:
  flood-distroless:
    volumes:
      - "/your/data/path/:/data"
      - "/etc/localtime:/etc/localtime:ro"
    ports:
      - "3000:3000"
    read_only: true
    user: 1000:1000
    image: "guillaumedsde/flood-distroless:latest"
```

## 🖥️ Supported platforms

Currently this container supports only one (but widely used) platform:

- linux/amd64

I am waiting to see if Google implement their distroless Java images for other platforms (e.g. ARM based), for more information, see [here](https://github.com/GoogleContainerTools/distroless/issues/406) or [here](https://github.com/GoogleContainerTools/distroless/issues/377)

## 🙏 Credits

A couple of projects really helped me out while developing this container:

- 💽 [Flood](https://github.com/jesec/flood) _the_ awesome software
- 🏁 [s6-overlay](https://github.com/just-containers/s6-overlay) A simple, relatively small yet powerful set of init script for managing processes (especially in docker containers)
- 🥑 [Google's distroless](https://github.com/GoogleContainerTools/distroless) base docker images
- 🐋 The [Docker](https://github.com/docker) project (of course)
