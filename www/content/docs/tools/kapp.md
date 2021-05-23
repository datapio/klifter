+++
weight = 7
title = "kapp"
description = """
Deploy sets of Kubernetes resources as applications.
"""
toc = true
+++

# Overview

This tool is enabled by default to enable support for application packages.

# Usage

`kapp` can still be used in a Bash manifest, it is especially useful to deploy
manifests from a remote location.

## Sample pipeline

**vars.yml:**

```yaml
---
packages:
  - name: rabbitmq-cluster-operator
    kind: bundle
```

**bundles/rabbitmq-cluster-operator/10-deploy.sh:**

```bash
#!/bin/sh

set -eux

URL="https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml"
kapp deploy --yes -a rabbitmq-cluster-operator -f $URL
```

# What's next?

Read more about `kapp` in their
[documentation](https://carvel.dev/kapp/docs/latest/).
