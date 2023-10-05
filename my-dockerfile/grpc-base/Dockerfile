FROM golang:1.21

ENV PROTOBUF_VERSION 3.20.3

RUN apt-get update \
    && apt-get install -y wget net-tools bind9-utils protobuf-compiler unzip --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /practice-grpc
COPY . /practice-grpc


RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
