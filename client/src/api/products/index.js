function getProductEndpoint(req, res) {
  res.json([{ product_id: 'Hello world' }]);
}

module.exports = getProductEndpoint;
