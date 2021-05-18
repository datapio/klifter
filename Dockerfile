FROM python:3.9-slim-buster

RUN set -ex && \
    apt update && \
    apt install --no-install-recommends -y \
        apt-transport-https \
        ca-certificates \
        curl gnupg \
        lsb-release \
        sudo \
    && \
    rm -rf /var/lib/apt/lists/*

RUN pip install poetry

ADD . /workspace
WORKDIR /workspace

RUN set -ex && \
    useradd -s /bin/bash -d /workspace klifter-agent && \
    chown -R klifter-agent:klifter-agent /workspace && \
    useradd -ms /bin/bash klifter-restricted && \
    echo "klifter-agent ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/klifter

USER klifter-agent

RUN poetry install

ENV K8S_STATE_USER "klifter-restricted"

ENV K8S_STATE_SOURCE_KIND "local"

ENV K8S_STATE_SOURCE_LOCAL_DIR ""

ENV K8S_STATE_SOURCE_GIT_URL ""
ENV K8S_STATE_SOURCE_GIT_REF "main"
ENV K8S_STATE_SOURCE_GIT_DIR "."

CMD [ "poetry", "run", "ansible-playbook", "site.yml" ]
