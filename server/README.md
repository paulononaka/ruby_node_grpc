# Ruby Server

> Service 1: Discount calculator

## Requirements

This application runs on Docker.

## Setup

```
docker build -t server .
```

# Usage

```
docker run -it -p 50051:50051 server
```

## If you want to regenerate the protos

```
grpc_tools_ruby_protoc -I ../client/protos --ruby_out=lib --grpc_out=lib ../client/protos/discount_calculator.proto
```

## Questions?

> I'm glad to answer, just ping me via email paulononaka@gmail.com 😄
