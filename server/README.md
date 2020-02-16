# Ruby gRPC Server

> Service 1: Discount calculator

## Requirements

This application runs on [Docker](https://www.docker.com/).

## Setup

```
docker build -t server .
```

# Usage

```
docker run -it -p 50051:50051 server
```

... or just `rake` if you have Rake and Ruby already installed.

## If you want to regenerate the protos

Install grpc-tools:
```
gem install grpc-tools
```

Then:
```
rake generate_proto
```

## Questions?

> I'm glad to answer, just ping me via email paulononaka@gmail.com 😄
