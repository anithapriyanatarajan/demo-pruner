# demo-pruner
Sample repository for pruner demo

## Hello World Go Application

This repository contains a simple "Hello World" Go application that can be run locally or in a Docker container.

### Files:
- `main.go` - The main Go application file
- `go.mod` - Go module file
- `Dockerfile` - Multi-stage Docker build file
- `Makefile` - Build automation
- `.dockerignore` - Docker build context exclusions
- `.github/workflows/docker.yml` - GitHub Actions CI/CD pipeline

### Local Development

#### How to run:
```bash
go run main.go
```

#### How to build:
```bash
go build -o hello-world main.go
./hello-world
```

### Docker

#### Build and run with Docker:
```bash
# Build the image
docker build -t hello-world-go .

# Run the container
docker run --rm hello-world-go
```

#### Using Makefile:
```bash
# Build the image
make build

# Build and run
make run

# Push to registry (replace with your registry)
make push REGISTRY=docker.io/yourusername
# or
make push REGISTRY=ghcr.io/yourusername

# Clean up
make clean

# Show help
make help
```

#### Manual Docker commands:
```bash
# Build
docker build -t hello-world-go .

# Run
docker run --rm hello-world-go

# Tag for registry
docker tag hello-world-go your-registry/hello-world-go:latest

# Push to registry
docker push your-registry/hello-world-go:latest
```

### Registry Options

The application can be published to various container registries:

1. **Docker Hub**: `docker.io/yourusername/hello-world-go`
2. **GitHub Container Registry**: `ghcr.io/yourusername/hello-world-go`
3. **AWS ECR**: `your-account.dkr.ecr.region.amazonaws.com/hello-world-go`
4. **Google Container Registry**: `gcr.io/your-project/hello-world-go`

### CI/CD

The repository includes a GitHub Actions workflow that automatically:
- Builds the Docker image on every push to main
- Pushes to GitHub Container Registry (ghcr.io)
- Tags images based on Git tags and commits
