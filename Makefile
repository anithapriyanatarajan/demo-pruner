# Variables
IMAGE_NAME := hello-world-go
TAG := latest
REGISTRY := # Set your registry here (e.g., docker.io/username, ghcr.io/username)
FULL_IMAGE_NAME := $(if $(REGISTRY),$(REGISTRY)/$(IMAGE_NAME),$(IMAGE_NAME))

.PHONY: build run push clean help

# Build the Docker image
build:
	docker build -t $(FULL_IMAGE_NAME):$(TAG) .

# Run the container locally
run: build
	docker run --rm $(FULL_IMAGE_NAME):$(TAG)

# Tag and push to registry
push: build
	@if [ -z "$(REGISTRY)" ]; then \
		echo "Error: REGISTRY variable is not set. Please set it to your registry URL."; \
		echo "Example: make push REGISTRY=docker.io/yourusername"; \
		exit 1; \
	fi
	docker tag $(FULL_IMAGE_NAME):$(TAG) $(REGISTRY)/$(IMAGE_NAME):$(TAG)
	docker push $(REGISTRY)/$(IMAGE_NAME):$(TAG)

# Clean up local images
clean:
	docker rmi $(FULL_IMAGE_NAME):$(TAG) || true
	@if [ -n "$(REGISTRY)" ]; then \
		docker rmi $(REGISTRY)/$(IMAGE_NAME):$(TAG) || true; \
	fi

# Show help
help:
	@echo "Available targets:"
	@echo "  build   - Build the Docker image"
	@echo "  run     - Build and run the container locally"
	@echo "  push    - Build, tag and push to registry (requires REGISTRY variable)"
	@echo "  clean   - Remove local Docker images"
	@echo "  help    - Show this help message"
	@echo ""
	@echo "Example usage:"
	@echo "  make build"
	@echo "  make run"
	@echo "  make push REGISTRY=docker.io/yourusername"
	@echo "  make push REGISTRY=ghcr.io/yourusername"
