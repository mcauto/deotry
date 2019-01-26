#!/bin/bash

# Install gometalint
curl -L https://git.io/vp6lP | sh && ls bin/* && sudo mv -f bin/* /usr/local/bin
# Install goreportcard-cli
go get -u github.com/gojp/goreportcard/cmd/goreportcard-cli
# Install gocov
go get -u github.com/axw/gocov/gocov && which gocov
# Install dep
curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh