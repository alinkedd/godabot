.PHONY: install dev-deps format lint test clean image push

APP=$(shell basename -s .git $(shell git remote get-url origin))
NAMESPACE=alinkedd
# NOTE: at least one commit and one tag are required in repository
VERSION=$(shell git describe --abbrev=0 --tags)-$(shell git rev-parse --short HEAD)
TARGET_OS=linux #windows
TARGET_ARCH=arm64 #amd64
IMAGE_NAME=${NAMESPACE}/${APP}:${VERSION}-${TARGET_ARCH}

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

clean:
	rm -rf godabot

image:
	docker build . -t ${IMAGE_NAME}

push:
	docker push ${IMAGE_NAME}
