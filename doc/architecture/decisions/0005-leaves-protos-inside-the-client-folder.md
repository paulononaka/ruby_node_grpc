# Leaves protos inside the client folder

Date: 2020-02-16
​
## Decision

Leaving protos inside the client since we are using Node with @grpc/proto-loader that dynamically
generates the code at runtime so that it needs to have access to the protos files and since we are using
the Dockerfile inside each folder/project, docker can not access files outside its context.
We may change our mind, but for now this seems an easy solution.