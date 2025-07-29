# Build stage
FROM golang:1.21-alpine AS builder

WORKDIR /app

# Copy go mod files
COPY go.mod go.sum* ./

# Download dependencies
RUN go mod download

# Copy source code
COPY . .

# Build the application
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

# Final stage
FROM alpine:latest

# Install ca-certificates for HTTPS requests
RUN apk --no-cache add ca-certificates

# Create a non-root user
RUN addgroup -g 1001 appgroup && \
    adduser -D -u 1001 -G appgroup appuser

WORKDIR /home/appuser/

# Copy the binary from builder stage
COPY --from=builder /app/main .

# Change ownership to the non-root user
RUN chown appuser:appgroup main

# Switch to non-root user
USER appuser

# Expose port (optional, since this is a simple CLI app)
EXPOSE 8080

# Run the binary
CMD ["./main"]
