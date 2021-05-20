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
