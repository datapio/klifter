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

ENV K8S_STATE_SOURCE_URL ""
ENV K8S_STATE_SOURCE_REF ""

CMD [ "poetry", "run", "ansible-playbook", "site.yml" ]
