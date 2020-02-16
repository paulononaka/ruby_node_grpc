# Server and client are in the same git repo with its corresponding dockerfile each

Date: 2020-02-16
​
## Decision

Server and client are in the same git repo. 
Ruby as the gRPC Server in the `server` folder and Node as the gRPC client in the `client` folder.
Each one with its corresponding dockerfile inside each folder. 