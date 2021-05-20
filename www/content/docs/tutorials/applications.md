+++
weight = 3
title = "Writing applications"
description = """
Learn how to write Kubernetes applications with [kapp](https://carvel.dev/kapp).
"""
toc = true
+++

# Sample pipeline

Considering the following `vars.yml`:

```yaml
---
packages:
  - name: foobar
    kind: application
```

**klifter** will expect a folder `applications/foobar` to exist, containing all
the Kubernetes resources that are part of the application to be deployed.

# Generate applications

Applications can be generated with `ytt` or `helm template`.

For example, write the following YAML to `vars.yml`:

```yaml
---
tools:
 - vault
 - helm

packages:
 - name: generate-foobar
   kind: bundle
 - name: foobar
   kind: applications

environment:
 - VAULT_TOKEN
```

And create the following tree:

```
|-- charts/
|   |-- foobar-chart/
|       |-- ...
|-- bundles/
|   |-- generate-foobar/
|       |-- 10-helm-template.sh
|-- applications/
|   |-- foobar/
|       |-- .gitkeep
|-- vars.yml
```

Write to the `bundles/generate-foobar/10-helm-template.sh` script the
following:

```bash
#!/bin/bash

set -eux

VAULT="vault read secret/foobar-values -format yaml"
HELM="helm template foobar ./charts/foobar-chart -n foobar-system -f -"

$VAULT | $HELM > ./applications/foobar/manifest.yml
```

# What's next?

Learn more about [kapp](https://carvel.dev/kapp/docs/latest/) or read the
[Tools](/docs/tools/) reference.
