const repository = require('../../repository/repository');
const service = require('../../service/service');

async function getProductEndpoint(req, res) {
  const discountRequest = { product_id: '1', user_id: '1' };

  try {
    res.json(await service.getDiscount(discountRequest));
  } catch (e) {
    res.json(repository.getProducts());
  }
}

module.exports = getProductEndpoint;
