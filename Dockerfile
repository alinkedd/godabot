# Copy current repository and create an executable using golang image
FROM golang:1.21 as builder
WORKDIR /go/src/app
COPY . .
RUN make build

# Copy ssl certificates and copy and run the executable using scratch image
FROM scratch
WORKDIR /
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /go/src/app/godabot .
ENTRYPOINT [ "./godabot" ]
