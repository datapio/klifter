+++
weight = 5
title = "Writing custom tools"
description = """
Learn how to enhance your pipeline capabilities with custom tools.
"""
toc = true
+++

# Overview

Tools installation are done with a set of [Ansible](https://ansible.com) tasks.

Those tasks are located at `/workspace/roles/k8s-state/tasks/tools/<tool name>.yml`
in the **klifter** Docker image.

# Adding custom tools

If you create a folder `/workspace/roles/k8s-state/tasks/tools/custom/`, every
YAML file in that folder will identify a tool named `custom/<tool name>`.

## Sample Tool

**/workspace/roles/k8s-state/tasks/tools/custom/curl.yml:**

```yaml
---
- name: "curl : install package"
  become: yes
  shell: apt install -y curl
```

## Sample pipeline

**vars.yml:**

```yaml
---
tools:
  - custom/curl
```

# Mount as volume

When running your pipeline with the **klifter** Docker image, you can mount
your custom tools folder directly:

```shell
$ docker run --rm -it \
      -v $HOME/.kube:/workspace/.kube \
      -v $HOME/klifter/custom-tools:/workspace/roles/k8s-state/tasks/tools/custom \
      -e K8S_STATE_SOURCE_KIND=git \
      -e K8S_STATE_SOURCE_GIT_URL=https://github.com/example/example.git \
      -e K8S_STATE_SOURCE_GIT_REF=main \
      ghcr.io/datapio/klifter:latest
```