+++
weight = 2
title = "kustomize"
description = """
Kubernetes Native configuration management.
"""
toc = true
+++

# Overview

Kustomize provides a solution for customizing Kubernetes resource configuration
free from templates and DSLs.

Kustomize lets you customize raw, template-free YAML files for multiple
purposes, leaving the original YAML untouched and usable as is.

Kustomize targets kubernetes; it understands and can patch *kubernetes style*
API objects. It’s like [make](https://www.gnu.org/software/make), in that what
it does is declared in a file, and it’s like [sed](https://www.gnu.org/software/sed),
in that it emits edited text.

# Installation

To enable this tool, add this to your `vars.yml`:

```yaml
---
tools:
  - kustomize
```

# Usage

Read more about [Kustomize](https://kustomize.io) on their
[documentation](https://kubectl.docs.kubernetes.io/guides/introduction/kustomize/).
