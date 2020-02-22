const service = require('../../service/service');

async function getProductEndpoint(req, res) {
  res.json(await service.getDiscount());
}

module.exports = getProductEndpoint;
