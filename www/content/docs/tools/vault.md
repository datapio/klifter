+++
weight = 8
title = "vault"
description = """
Read and write secrets from [Vault](https://vaultproject.io).
"""
toc = true
+++

# Overview

[Vault](https://vaultproject.io) is a secret store for tokens, passwords,
certificates, encryption keys and other sensitive data.

This tool provides a client to interact with *Vault*.


# Installation

To enable this tool, add this to your `vars.yml`:

```yaml
---
tools:
  - vault
```

# Configuration

To authenticate against [Vault](https://vaultproject.io), you can either:

 - set the `VAULT_TOKEN` environment variable
 - mount the token to the file `/workspace/.vault-token`

Read this [article](https://www.vaultproject.io/docs/commands#environment-variables)
to learn more about *Vault* client's configuration.

# Usage

## Sample pipeline

**vars.yml:**

```yaml
---
tools:
  - vault

packages:
  - name: update-k8s-secrets
    kind: bundle

environment:
  - VAULT_TOKEN
  - VAULT_ADDR
```

**bundles/update-k8s-secrets/update.sh:**

```bash
#!/bin/bash

set -euxo pipefail

vault_secret="secret/app"

APP_SECRET="$(vault kv get -format=json $vault_secret)"
APP_USERNAME="$(echo $APP_SECRET | jq -r .data.data.username)"
APP_PASSWORD="$(echo $APP_SECRET | jq -r .data.data.password)"

cat <<EOF | kubectl apply -f-
---
apiVersion: v1
kind: Secret
metadata:
  name: myapp
  namespace: default
stringData:
  username: "$APP_USERNAME"
  password: "$APP_PASSWORD"
EOF
```

# What's next?

Learn more about *Vault* in their
[documentation](https://learn.hashicorp.com/vault).
