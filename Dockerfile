FROM golang:1 AS builder

WORKDIR /go/src/natscli/
COPY go.mod go.sum ./
RUN go mod download -x
COPY . .
RUN go install -v .

FROM opensuse/leap:latest
COPY --from=builder /go/bin/natscli /usr/local/bin
ENTRYPOINT ["/usr/local/bin/natscli"]
