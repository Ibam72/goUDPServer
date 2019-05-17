NAME     := coco
REVISION := $(shell git rev-parse --short HEAD)
GOCMD=go

GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get

## Setup
setup:
	$(GOGET) golang.org/x/tools/cmd/goimports
	$(GOGET) github.com/Songmu/make2help/cmd/make2help
	$(GOGET) github.com/pkg/errors
	$(GOGET) -u github.com/golang/dep/cmd/dep
	$(GOGET) -u golang.org/x/lint/golint

## Show help
help:
	@make2help $(MAKEFILE_LIST)

## deps the project's dependencies
deps: setup
	dep ensure

## update the locked versions of all dependencies
update: setup
	dep ensure -update

## Build binaries
build:
	mkdir -p $(BINDIR)
	$(GOBUILD) -ldflags "$(LDFLAGS)" -o $(BINDIR)/$(NAME) cmd/main.go

build-linux:
	mkdir -p $(releaseBINDIR)
	GOOS=linux GOARCH=amd64 $(GOBUILD) -ldflags "$(LDFLAGS)" -o $(releaseBINDIR)/$(NAME) cmd/main.go
