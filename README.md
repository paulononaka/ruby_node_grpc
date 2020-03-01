[![mailto:paulononaka@email.com](https://img.shields.io/badge/contact-@paulononaka-blue.svg?style=flat)](mailto:paulononaka@email.com)
![CI](https://github.com/paulononaka/ruby_node_grpc/workflows/CI/badge.svg)

<hr />
<h2 align="center">
  ✨ Ruby & Node with gRPC ✨
</h2>
<hr /> 

Two microservices that communicates through [gRPC](https://grpc.io) that together displays a product list with custom discounts per user. 

### Project structure

```
client      // Client folder written in NodeJS
data        // Local storaged data in JSON
doc         // Architecture Decision Records
protos      // Protocol buffers
server      // Server folder written in Ruby
```

## Requirements

This application relies on [Docker](https://www.docker.com/).

### Setup

```
docker-compose build
```

### Running

```
docker-compose up
```

# Server

A gRPC server made in Ruby (server folder).

The server service receives two RPC arguments and answers with the discount.

### Server structure

```
server
├── lib         // Serve service functions that connects to the gRPC Client
│   └── models  // Models that represents the local storaged data
├── spec        // Rspec tests  
```

### How to regenerate the protos

> Install grpc-tools:
```shell script
gem install grpc-tools
```

> Then:
```shell script
rake generate_proto
```

# Client

A gRPC client made in Node (client folder).

The gRPC client consumes the gRPC server and exposes a HTTP endpoint GET /product.

### Client structure

```
client
├── src
│   └── api     // Espresso endpoints
│   └── repository  // Functions to returns the local storaged data
│   └── service     // Client services functions that connects to the gRPC Server 
```

### Request samples

`GET /` - Health check

```
Ok!
```

`GET /product?userId=1` - Returns a list of products and its discounts for a specific user.

```
[
  {
    id: "1",
    price_in_cents: 350,
    title: "Coca Cola",
    description: "It is nice to drink Coca",
    discount: {
      pct: 0,
      value_in_cents: 24
    }
  },
  {
    id: "2",
    price_in_cents: 2000,
    title: "Cake",
    description: "It is good to eat cake too",
    discount: {
      pct: 0,
      value_in_cents: 24
    }
  }
]
```
