const PROTO_PATH = `${__dirname}/../protos/discount_calculator.proto`;

const grpc = require('grpc');
const protoLoader = require('@grpc/proto-loader');

const packageDefinition = protoLoader.loadSync(
  PROTO_PATH, {
    keepCase: true, longs: String, enums: String, defaults: true, oneofs: true,
  },
);
const proto = grpc.loadPackageDefinition(packageDefinition);

function main() {
  const client = new proto.DiscountCalculator('host.docker.internal:50051', grpc.credentials.createInsecure());
  const user = { id: '1', first_name: 'Paulo', last_name: 'Nonaka' };

  client.getDiscount(user, (err, response) => {
    console.log('Error:', err);
    console.log('Response:', response);
  });
}

main();
