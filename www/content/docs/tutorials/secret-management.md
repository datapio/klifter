+++
weight = 4
title = "Secret Management"
description = """
Learn how to use secret values within your deployment pipeline.
"""
toc = true
+++

# Authenticating to Kubernetes

**klifter** needs a `kubeconfig` to interact with the Kubernetes cluster.

If it runs within a Kubernetes Pod, `kubectl` will work out of the box.
Otherwise, you'll need to mount your configuration file within the Docker image:

 - at `/workspace/.kube/config`
 - somewhere else and set the `KUBECONFIG` environment variable

# Reading secrets

## Using Environment variables

The first method to manage secret values is through environment variables.

Within the `vars.yml` file, you can specify which environment variables will be
propagated to the bundles:

```yaml
---
environment:
  - DOCKER_USERNAME
  - DOCKER_PASSWORD
  - VAULT_TOKEN
  # ...
```

If **klifter** is executed within a Kubernetes Pod, you can use Kubernetes
Secrets to populate the Pod's environment.

## Using Kubernetes Secrets

Within a Bash manifest, you can use `kubectl` to fetch a secret:

```bash
#!/bin/bash

set -eux

SECRET_VALUE=$(kubectl get secret foobar --format=json | jq .data)
```

## Using Vault

When you enable the `vault` tool in the `vars.yml` file:

```yaml
---
tools:
  - vault
```

You can then use the `vault` command within a Bash manifest:

```bash
#!/bin/bash

set -eux

SECRET_VALUE=$(vault read secret/foobar -format=json)
```

To authenticate against [Vault](https://vaultproject.io), you can either:

 - set the `VAULT_TOKEN` environment variable
 - mount the token to the file `/workspace/.vault-token`

Read this [article](https://www.vaultproject.io/docs/commands#environment-variables)
to learn more about *Vault* client's configuration.

# What's next?

Read the [Tools](/docs/tools/) reference.
