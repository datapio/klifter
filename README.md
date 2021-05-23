# klifter

**klifter** is an [Ansible](https://ansible.com) playbook used to deploy a
complete [Kubernetes](https://kubernetes.io) infrastructure from a
[Git](https://git-scm.com) repository.

It supports:

 - executing Bash scripts
 - building Docker images with [docker](https://docker.com) or [kbld](https://carvel.dev/kbld)
 - applying Kubernetes manifests (through `kubectl apply` or with [kustomize](https://kustomize.io))
 - deploying Kubernetes applications with [Helm](https://helm.sh) or [kapp](https://carvel.dev/kapp)
 - generating Kubernetes applications with [ytt](https://carvel.dev/ytt) or `helm template`

## Usage

See [the documentation](https://klifter.datapio.co/docs/) for more information.
