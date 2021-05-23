+++
weight = 2
title = "Writing bundles"
description = """
Learn how to write a deployable bundle to generate, build, and push your
artefacts.
"""
toc = true
+++

# Sample pipeline

Considering the following `vars.yml`:

```yaml
---
packages:
  - name: foobar
    kind: bundle

environment:
  - FOOBAR
```

**klifter** will expect a folder `bundles/foobar` to exist, containing all the
manifests that needs to be deployed.

> **NB:** Environment variables not listed in the `environment` property won't
> be available in Bash manifests.

# Manifest kinds

## Kubernetes Manifest

Those manifests ends with the extension `.yml` or `.yaml` and contains one or
more Kubernetes resource to deploy:

```yaml
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: foobar
data:
  foo: bar
```

This manifest will be deployed using the command `kubectl apply`.

> **NB:** If a namespaced resource does not specify a namespace (just like the
> example above), the default one (specified in the kubeconfig used by `kubectl`
> will be used instead.

## Bash Manifest

Those manifests ends with the extension `.sh` and contains instructions to
perform:

```bash
#!/bin/bash

set -eux # recommended for safety reasons

kubectl wait --for=condition=complete pod/mypod-xxxxxxxxxx-xxxxx
```

> **NB:** Tools listed in the `tools` property of the `vars.yml` file will be
> available as commands within your Shell Script.

> **NB:** Bash Manifests are executed under another user, specified by the
> environment variable `K8S_STATE_USER` (defaults to: `nobody`, already
> configured properly within the Docker image).

> **NB:** The current working directory (or `PWD` environment variable) will be
> set to the root of the deployment pipeline.

# Manifest ordering

**klifter** use the command `find` to discover the manifests within a bundle.

This means that you can have any layout you want to organize your bundle.

The discovered manifests are then **sorted by their absolute path** and executed
in alphabetical order.

Which means you can directly control the order of deployment via their file
names:

 - `10-do-this-first.sh`
 - `20-then-this.sh`
 - `30-then-those-ones/hello.yml`
 - `30-then-those-ones/world.yml`

# What's next?

Learn how to write an [application package](/docs/tutorials/applications/) or
discover the [Tools](/docs/tools/) reference.
