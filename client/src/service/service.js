const protoClient = require('../protos/proto_client');

function getDiscount() {
  const getDiscountRequest = { product_id: '1', user_id: '123' };

  return new Promise(((fulfilled, rejected) => {
    protoClient.getDiscount(getDiscountRequest, (err, response) => {
      if (err !== null) {
        rejected(err);
      }
      fulfilled(response);
    });
  }));
}

module.exports = { getDiscount };
