FROM python:3.9-slim-buster

RUN apt update && \
    apt install --no-install-recommends -y \
        apt-transport-https \
        ca-certificates \
        curl gnupg \
        lsb-release && \
    rm -rf /var/lib/apt/lists/*

RUN pip install poetry

ADD . /workspace
WORKDIR /workspace

RUN poetry install

VOLUME /data

ENV K8S_STATE_SOURCE_KIND "local"

ENV K8S_STATE_SOURCE_LOCAL_DIR "/data"

ENV K8S_STATE_SOURCE_GIT_URL ""
ENV K8S_STATE_SOURCE_GIT_REF "main"
ENV K8S_STATE_SOURCE_GIT_DIR "."

CMD [ "poetry", "run", "ansible-playbook", "site.yml" ]
