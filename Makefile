# NOTE: 1: this repo must have .git and at least one commit and one tag
# NOTE: 2: a few of these commands are compatible only with *nix systems

.PHONY: install dev-deps format lint test push clean

APP        :=$(shell basename -s .git $(shell git remote get-url origin))
NAMESPACE  :=alinkedd
VERSION    :=$(shell git describe --abbrev=0 --tags)-$(shell git rev-parse --short HEAD)
TARGET_OS  ?=$(shell uname 2>/dev/null | tr A-Z a-z || echo "linux")
TARGET_ARCH?=$(shell dpkg --print-architecture 2>/dev/null || echo "amd64")
IMAGE_NAME  =${NAMESPACE}/${APP}:${VERSION}-${TARGET_OS}-${TARGET_ARCH}

install:
	go get

# TODO: manage dev dependencies in a more advance way
dev-deps:
	go install honnef.co/go/tools/cmd/staticcheck@latest

format:
	gofmt -s -w ./

lint:
	staticcheck ./

test:
	go test -v

build: format install
	CGO_ENABLED=0 GOOS=${TARGET_OS} GOARCH=${TARGET_ARCH} go build -v -o godabot -ldflags "-X="github.com/alinkedd/godabot/cmd.appVersion=${VERSION}

image:
	docker build -t ${IMAGE_NAME} --build-arg TARGET_OS=${TARGET_OS} --build-arg TARGET_ARCH=${TARGET_ARCH} .

linux darwin windows:
	$(MAKE) build TARGET_OS=$@ TARGET_ARCH=${TARGET_ARCH}
	$(MAKE) image TARGET_OS=$@ TARGET_ARCH=${TARGET_ARCH}

amd64 arm64 arm:
	$(MAKE) build TARGET_OS=${TARGET_OS} TARGET_ARCH=$@
	$(MAKE) image TARGET_OS=${TARGET_OS} TARGET_ARCH=$@

# TODO: change to GCR
push:
	docker push ${IMAGE_NAME}

# removes images of the current version of repository for all OS/architecture
clean:
	rm -rf godabot
	docker rmi -f $$(docker images --filter=reference='${NAMESPACE}/${APP}:${VERSION}-*' -q) \
	2>/dev/null || true
# if no image is found, `2>/dev/null` will suppress warning about having at least
# 1 argument and `|| true` will suppress `make`'s error
