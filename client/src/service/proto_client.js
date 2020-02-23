const PROTO_PATH = `${__dirname}/../../../protos/discount_calculator.proto`;
const gRPC = require('grpc');
const protoLoader = require('@grpc/proto-loader');

const packageDefinition = protoLoader.loadSync(
  PROTO_PATH, {
    keepCase: true, longs: String, enums: String, defaults: true, oneofs: true,
  },
);
const protoClient = gRPC.loadPackageDefinition(packageDefinition);
const client = new protoClient.proto.DiscountCalculator('host.docker.internal:50051', gRPC.credentials.createInsecure());

module.exports = client;
