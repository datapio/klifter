+++
weight = 5
title = "docker"
description = """
Build, pull, push and run Docker images.
"""
toc = true
+++

# Overview

[Docker](https://docker.com) is an implementation of
[OCI Containers](https://opencontainers.org/). It is used to:

 - build OCI container images
 - pull OCI container images from a registry
 - push OCI container images to a registry
 - run OCI containers

# Installation

To enable this tool, add this to your `vars.yml`:

```yaml
---
tools:
  - docker
```

# Configuration

In order to run Docker within your bundles, you will need to either:

 - mount the Docker daemon socket to `/var/run/docker.sock`
 - set the environment variable `DOCKER_HOST`

If you execute **klifter** within a Kubernetes Pod, you can add a sidecar
container with the Docker image `docker:dind`.

# Usage

Once your Docker daemon is set up and running, you can use the `docker` command
within Bash manifests in a bundle.

## Sample example

**vars.yml:**

```yaml
---
tools:
  - docker

packages:
  - name: build-push-docker-image
    kind: bundle

environment:
  - DOCKER_USERNAME
  - DOCKER_PASSWORD
```

**containers/demo.dockerfile:**

```dockerfile
FROM alpine:latest

CMD [ "/bin/sh", "-c", "echo 'hello world'"]
```

**bundles/build-push-docker-image/10-build.sh:**

```bash
#!/bin/bash

set -eux

docker build -t example/hello-world:latest -f containers.demo.dockerfile .
```

**bundles/build-push-docker-image/20-push.sh:**

```bash
#!/bin/bash

set -eux

echo $DOCKER_PASSWORD | docker login --username $DOCKER_USERNAME --password-stdin

docker push example/hello-world:latest
```

# What's next?

Read more about Docker on their [documentation](https://docs.docker.com/).
