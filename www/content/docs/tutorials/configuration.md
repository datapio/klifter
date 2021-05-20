+++
weight = 1
title = "Configuration"
description = """
Learn how to configure your deployment pipeline and the different concepts
provided by **klifter**.
"""
toc = true
markup = "mmark"
+++

# Overview

At the root of your pipeline, there is a file name `vars.yml`.

This file defines:

 - what tools will be used by your pipeline
 - what packages will be deployed by your pipeline

There is currently 2 kinds of packages:

 - a bundle, consisting of a set of manifests that will be executed to converge
   the state of your Kubernetes cluster towards your desired state
 - an application, consisting of a set of Kubernetes resources deployed with
   [kapp](https://carvel.dev/kapp)

And the following tools are supported:

 - [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/), enabled by default
 - [kapp](https://carvel.dev/kapp), enabled by default
 - [helm](https://helm.sh)
 - [kustomize](https://kustomize.io)
 - [ytt](https://carvel.dev/ytt)
 - [docker](https://docker.com)
 - [kbld](https://carvel.dev/kbld)

Those tools allow your pipeline to:

 - build and push Docker images to a Container Registry
 - deploy static or templated Kubernetes resources

# Pipeline layout

Alongside the `vars.yml` file, you'll find a `bundles` folder and an
`applications` folder, containing the packages to deploy.

```
|-- bundles/
|   |-- <bundle name>/
|       |-- 10-kubernetes-manifest.yml
|       |-- 20-bash-manifest.sh
|-- applications/
|   |-- <application name>/
|       |-- kubernetes-manifest.yml
|-- vars.yml
```

Packages are deployed in the order they are defined in the `vars.yml` file.

In a bundle, manifests are applied in an alphabetical order and currently
supports the following kinds:

 - a Kubernetes manifest, deployed with `kubectl apply`, named `*.yml` or `*.yaml`
 - a Shell manifest, executed with `bash`, named `*.sh`

For each application, a Kubernetes namespace named
`klifter-system-app-<application name>` will be created, and used by `kapp` to
deploy the application.

# Example configuration

**vars.yml:**

```yaml
---

tools:
  - helm
  - kbld

packages:
  - name: build-foobar-images
    kind: bundle
  - name: generate-foobar-app
    kind: bundle
  - name: foobar
    kind: application

environment:
  - DOCKER_HOST
  - DOCKER_USERNAME
  - DOCKER_PASSWORD
```

The above configuration file will expect:

 - a `bundles/build-foobar-images/` folder
 - a `bundles/generate-foobar-app/` folder
 - an `applications/foobar/` folder
 - the listed environment variables (in the `environment` property) to be set

**NB:** A bundle can use `ytt` or `helm template` to generate files in a later
application folder.

# Environment variables

{.table .is-bordered .is-striped .is-hoverable .is-fullwidth}
| Environment Variable | Description | Required | Default Value |
| --- | --- | --- | --- |
| `K8S_STATE_USER` | User used to execute Bash manifests | ❌ | `nobody` |
| `K8S_STATE_SOURCE_KIND` | Either `git` or `local` | ✅ | N/A |

If `K8S_STATE_SOURCE_KIND` is set to `git`:

{.table .is-bordered .is-striped .is-hoverable .is-fullwidth}
| Environment Variable | Description | Required | Default Value |
| --- | --- | --- | --- |
| `K8S_STATE_SOURCE_GIT_URL` | URL to the Git repository to clone | ✅ | N/A |
| `K8S_STATE_SOURCE_GIT_REF` | Branch, tag or commit to clone | ❌  | `main` |
| `K8S_STATE_SOURCE_GIT_DIR` | Directory within the repository containing the source | ❌ | `.` |

If it is set to `local`:

{.table .is-bordered .is-striped .is-hoverable .is-fullwidth}
| Environment Variable | Description | Required | Default Value |
| --- | --- | --- | --- |
| `K8S_STATE_SOURCE_LOCAL_DIR` | Absolute path to the folder containing the source | ✅ | N/A |

The **klifter** Docker image provides the following defaults:

{.table .is-bordered .is-striped .is-hoverable .is-fullwidth}
| Environment Variable | Value |
| --- | --- |
| `K8S_STATE_USER` | `klifter-restricted` |
| `K8S_STATE_SOURCE_KIND` | `local` |
| `K8S_STATE_SOURCE_LOCAL_DIR` | `"/data"` |
| `K8S_STATE_SOURCE_GIT_REF` | `"main"` |
| `K8S_STATE_SOURCE_GIT_DIR` | `"."` |

It also provides the following users:

 - `klifter-agent` to run the [Ansible](https://ansible.com) playbook
 - `klifter-restricted` to run the Bash manifests

> **NB:** It is recommended to not override the `K8S_STATE_USER` in the Docker
> image.

# What's next?

Learn how to write [bundles](/docs/tutorials/bundles/) or
[applications](/docs/tutorials/applications/).
