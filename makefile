
PKG_LIST := $(shell go list ./... | grep -v /vendor/)
GO_FILES := $(shell find . -name '*.go' | grep -v /vendor/ | grep -v _test.go)


all: lint test

lint: dep
	@echo "Start golint"
	@golint -set_exit_status ${PKG_LIST}

test: dep
	@echo "Start test"
	@go test -short ${PKG_LIST}

dep:
	@echo "Install dependency"
	@dep ensure

.PHONY: all lint test dep