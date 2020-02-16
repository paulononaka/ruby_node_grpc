const PROTO_PATH = `${__dirname}/../protos/discount_calculator.proto`;
const grpc = require('grpc');
const protoLoader = require('@grpc/proto-loader');

const packageDefinition = protoLoader.loadSync(
  PROTO_PATH, {
    keepCase: true, longs: String, enums: String, defaults: true, oneofs: true,
  },
);
const proto = grpc.loadPackageDefinition(packageDefinition);

const http = require('http');
const app = require('./app');

const server = http.createServer(app);
const port = '3000';

app.set('port', port);

function onListening() {
  console.log(`Listening on ${port}`);
}

server.on('listening', onListening);
server.listen(port);

function main() {
  const client = new proto.DiscountCalculator('host.docker.internal:50051', grpc.credentials.createInsecure());

  const getDiscountRequest = { product_id: '5000', user_id: '123' };

  client.getDiscount(getDiscountRequest, (err, response) => {
    console.log('Error:', err);
    console.log('Response:', response);
  });
}

main();

module.exports = app;
