[![mailto:paulononaka@email.com](https://img.shields.io/badge/contact-@paulononaka-blue.svg?style=flat)](mailto:paulononaka@email.com)
![CI](https://github.com/paulononaka/ruby_node_grpc/workflows/CI/badge.svg)

<hr />
<h2 align="center">
  ✨ Ruby & Node with gRPC ✨
</h2>
<hr /> 

Two microservices that communicates through [gRPC](https://grpc.io) that together displays a product list with custom discounts per user. 

## Requirements

This application relies on [Docker](https://www.docker.com/).

## Setup

```
docker-compose build
```

## Usage

```
docker-compose up
```

# Server

A gRPC server made in Ruby (server folder). 

The server service receives two RPC arguments and answers with the discount.

> If you want to regenerate the protos

Install grpc-tools:
```
gem install grpc-tools
```

Then:
```
rake generate_proto
```

# Client

A gRPC client made in node (client folder).

The gRPC client consumes the gRPC server and exposes a HTTP endpoint GET /product that returns a list of products and its discounts for a specific user.

## Questions?

>I'm glad to answer, just ping me via email paulononaka@gmail.com 😄
