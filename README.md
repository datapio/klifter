# klifter

This project provides an [ansible](https://ansible.com) playbook to deploy a
complete Kubernetes infrastructure from a Git repository.

It supports:

 - applying Kubernetes manifests (through `kubectl apply` or with `kustomize`)
 - deploying Helm charts
 - executing Bash scripts
 - building Docker images with `docker` or [kbld](https://carbel.dev/kbld)
 - deploying Kubernetes applications (with [kapp](https://carvel.dev/kapp))
 - generating Kubernetes applications to deploy (with [ytt](https://carvel.dev/ytt) or `helm template`)

## Usage

> **TODO**

See [the documentation](https://github.com/datapio/klifter/wiki) for
more information.
