# We want to use bash
SHELL:=/bin/bash

# Target for building a Go binary
.PHONY: build
build:
	@echo "Building tuf-client..."
	@go build -o tuf-client ./cmd/tuf-client/main.go

# Target for demoing the tuf-client cli
.PHONY: test
test: build
	@echo "Clearing any leftover artifacts..."
	./tuf-client reset --force
	@echo "Initializing the following https://jku.github.io/tuf-demo/ TUF repository"
	@sleep 2
	./tuf-client init --url https://jku.github.io/tuf-demo/metadata
	@echo "Downloading the following target file - rdimitrov/artifact-example.md"
	@sleep 2
	./tuf-client get --url https://jku.github.io/tuf-demo/metadata --turl https://jku.github.io/tuf-demo/targets rdimitrov/artifact-example.md

# Clean target
.PHONY: clean
clean:
	@rm -rf tuf_download
	@rm -rf tuf_metadata
	@rm -f tuf-client
