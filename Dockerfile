ARG TARGET_OS=linux
ARG TARGET_ARCH=amd64

# Copy current repository and create an executable using golang image
FROM quay.io/projectquay/golang:1.21 as builder
WORKDIR /go/src/app
COPY . .
ARG TARGET_OS
ARG TARGET_ARCH
RUN make build TARGET_OS=$TARGET_OS TARGET_ARCH=$TARGET_ARCH

# Copy ssl certificates and copy and run the executable using scratch image
FROM scratch
WORKDIR /
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /go/src/app/godabot .
ENTRYPOINT [ "./godabot" ]
