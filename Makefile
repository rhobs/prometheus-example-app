# Use the git tag name if at a tagged commit, otherwise use the short commit hash
VERSION:=$(shell git describe --tags --exact-match --match "v*" 2>/dev/null || git rev-parse --short HEAD)

IMAGE_NAME ?= prometheus-example-app

LDFLAGS="-X main.appVersion=$(VERSION)"

.PHONY : all build image

all: build

build:
	CGO_ENABLED=0 go build -ldflags=$(LDFLAGS) -o prometheus-example-app --installsuffix cgo main.go

image:
	docker build -t "ghcr.io/rhobs/$(IMAGE_NAME):$(VERSION)" .
