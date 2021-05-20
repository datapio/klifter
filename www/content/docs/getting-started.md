+++
weight = 1
title = "Getting Started"
description = """
Write your first deployment project and deploy to your Kubernetes cluster in
less than 5 minutes.
"""
toc = true
+++

# Overview

**klifter** is an [Ansible](https://ansible.com) playbook used to deploy a
complete [Kubernetes](https://kubernetes.io) infrastructure from a
[Git](https://git-scm.com) repository.

It supports:

 - executing Bash scripts
 - building Docker images with [docker](https://docker.com) or [kbld](https://carvel.dev/kbld)
 - applying Kubernetes manifests (through `kubectl apply` or with [kustomize](https://kustomize.io))
 - deploying Kubernetes applications with [Helm](https://helm.sh) or [kapp](https://carvel.dev/kapp)
 - generating Kubernetes applications with [ytt](https://carvel.dev/ytt) or `helm template`

# Installation

**klifter** is distributed as a Docker image but you can also install it
manually from sources.

## With Docker

The Docker image is hosted on [Github Container Registry](https://ghcr.io):

```shell
$ docker pull ghcr.io/datapio/klifter:latest
```

## From sources

You will need [Python 3.9](https://python.org) or higher and [Poetry](https://python-poetry.org):

```shell
$ git clone https://github.com/datapio/klifter
$ cd klifter
$ poetry install
```

> **NB:** Only [Debian](https://debian.org) is supported so far.

# Usage

**klifter** takes as input a *source*, which can be one of the following:

 - a Git repository
 - a local directory

In the future, we may support the following sources:

 - a *data-only* Docker container
 - a TAR/ZIP/... archive
 - a remote archive (via HTTP/HTTPS)

## Sample project

**vars.yml:**

```yaml
---
packages:
  - name: foobar
    kind: bundle
```

**bundles/foobar/10-namespace.yml:**

```yaml
---
apiVersion: v1
kind: Namespace
metadata:
  name: foobar
```

**bundles/foobar/20-helloworld.yml:**

```yaml
---
apiVersion: batch/v1
kind: Job
metadata:
  name: helloworld
  namespace: foobar
spec:
  template:
    spec:
      containers:
        - name: hello
          image: alpine:latest
          command: ["/bin/sh", "-c", "echo world"]
      restartPolicy: Never
  backoffLimit: 4
```

## Deploy

Assuming you have a working Kubernetes configuration on your host, you can run
the Docker image with your local project:

```shell
$ docker run --rm -it \
      -v $HOME/.kube:/workspace/.kube \
      -v /path/to/sample/project:/data \
      -e K8S_STATE_SOURCE_KIND=local \
      ghcr.io/datapio/klifter:latest
```

Or from a Git repository:

```shell
$ docker run --rm -it \
      -v $HOME/.kube:/workspace/.kube \
      -e K8S_STATE_SOURCE_KIND=git \
      -e K8S_STATE_SOURCE_GIT_URL=https://github.com/example/example.git \
      -e K8S_STATE_SOURCE_GIT_REF=main \
      ghcr.io/datapio/klifter:latest
```

To run the playbook from sources (environment will be read from a `.env` file):

```shell
$ poetry run bash run-playbook.sh
```

> **NB:** Running the playbook from sources will install the tools on your
> machine.

# What's next?

You can either read our [tutorials](/docs/tutorials/), or dive into the
[tools](/docs/tools/) reference.
