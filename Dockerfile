FROM golang:1.24 AS builder

WORKDIR /go/src/github.com/rhobs/prometheus-example-app
COPY . /go/src/github.com/rhobs/prometheus-example-app

RUN make build

FROM quay.io/prometheus/busybox:latest

COPY --from=builder /go/src/github.com/rhobs/prometheus-example-app/prometheus-example-app \
  /bin/prometheus-example-app

ENTRYPOINT ["/bin/prometheus-example-app"]
