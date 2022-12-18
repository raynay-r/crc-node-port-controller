TAG ?= $(shell git describe --match=NeVeRmAtCh --always --abbrev=40 --dirty)
CONTAINER_RUNTIME ?= podman

LDFLAGS = -ldflags '-s -w'

.PHONY: build
build:
	GOOS=linux CGO_ENABLED=0 go build $(LDFLAGS) -o node-port-controller .

.PHONY: vendor
vendor:
	go mod tidy
	go mod vendor

.PHONY: lint
lint:
	golangci-lint run

.PHONY: image
image:
	${CONTAINER_RUNTIME} build -t quay.io/crcont/node-ports-controller:$(TAG) -f Dockerfile .