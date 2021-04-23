.PHONY: all
all:
	@docker build -t ghcr.io/datapio/k8s-converge:latest -f Dockerfile .

.PHONY: run
run:
	@docker run --rm ghcr.io/datapio/k8s-converge:latest
