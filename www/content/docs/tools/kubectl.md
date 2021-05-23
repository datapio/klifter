+++
weight = 1
title = "kubectl"
description = """
Interact with the Kubernetes API Server.
"""
toc = true
+++

# Overview

This tool is enabled by default to enable support for Kubernetes manifests in a
bundle.

# Configuration

`kubectl` expects a *kubeconfig*. It can be located at `/workspace/.kube/config`
or any other path specified in the `KUBECONFIG` environment variable.

If **klifter** is executed within a Kubernetes Pod, the *kubeconfig* can be
omitted and `kubectl` will use the Pod's ServiceAccount to authenticate against
Kubernetes.

# Usage

`kubectl` can still be used in a Bash manifest, it is especially useful to wait
for some conditions.

## Sample pipeline

**vars.yml:**

```yaml
---
packages:
  - name: nginx-ingress
    kind: bundle
```

**bundles/nginx-ingress/10-helm-dependencies.yml:**

```yaml
---
apiVersion: helm.fluxcd.io/v1
kind: HelmRelease
metadata:
  name: nginx
  namespace: ingress-system
spec:
  wait: yes
  chart:
    repository: https://kubernetes.github.io/ingress-nginx
    name: ingress-nginx
    version: '3.30.0'
```

**bundles/nginx-ingress/15-wait-helm-release.sh:**

```bash
#!/usr/bin/env bash

set -eux

kubectl wait --for=condition=released -n ingress-system helmreleases/nginx
```

# What's next?

Read more about `kubectl` in their [documentation](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands).
