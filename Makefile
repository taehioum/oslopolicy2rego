# Copyright 2016 The OPA Authors.  All rights reserved.
# Use of this source code is governed by an Apache2
# license that can be found in the LICENSE file.

VERSION := 0.1

PACKAGES := $(shell go list ./.../)

GO := go
GOARCH := $(shell go env GOARCH)
GOOS := $(shell go env GOOS)

BIN := oslopolicy2rego_$(GOOS)_$(GOARCH)

.PHONY: all build clean cover deps fmt generate install test version

######################################################
#
# Development targets
#
######################################################

all: deps build test

version:
	@echo $(VERSION)

deps:
	$(GO) get gopkg.in/yaml.v2

generate:
	$(GO) generate

build: generate
	$(GO) build -o $(BIN)

install: generate
	$(GO) install

test: generate
	$(GO) test $(PACKAGES) -count 10

fmt:
	$(GO) fmt $(PACKAGES)

clean:
	rm -f oslopolicy2rego_*_*