const protoClient = require('../protos/proto_client');

function getDiscount(discountRequest) {
  return new Promise(((fulfilled, rejected) => {
    protoClient.getDiscount(discountRequest, (err, response) => {
      if (err !== null) {
        rejected(err);
      }
      fulfilled(response);
    });
  }));
}

module.exports = { getDiscount };
