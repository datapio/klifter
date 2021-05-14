.PHONY: all
all:
	@poetry install

.PHONY: run
run:
	@poetry run bash run-playbook.sh

.PHONY: docker/build
docker/build:
	@docker build -t ghcr.io/datapio/klifter:latest -f Dockerfile .

.PHONY: docker/run
docker/run:
	@docker run --rm ghcr.io/datapio/klifter:latest
