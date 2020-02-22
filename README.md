[![mailto:paulononaka@email.com](https://img.shields.io/badge/contact-@paulononaka-blue.svg?style=flat)](mailto:paulononaka@email.com)
![CI](https://github.com/paulononaka/ruby_node_grpc/workflows/CI/badge.svg)

<hr />
<h2 align="center">
  ✨ Ruby & Node with gRPC ✨
</h2>
<hr /> 

Two microservices that communicates through [gRPC](https://grpc.io) that together displays a product list with custom discounts per user. 

## Server

> A gRPC server made in Ruby (server folder). 

The server service receive two RPC arguments and answers with the discount.

## Client

> A gRPC client made in node (client folder).

The gRPC client consumes the gRPC server and exposes a HTTP endpoint GET /product that returns a list of products and its discounts for a specific user.

# Usage

> More of each service on its README inside each folder.

## Questions?

>I'm glad to answer, just ping me via email paulononaka@gmail.com 😄
