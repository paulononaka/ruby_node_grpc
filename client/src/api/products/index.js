const repository = require('../../repository/repository');
const service = require('../../service/service');

async function getProductEndpoint(req, res) {
  const originalProducts = repository.getProducts();
  const promises = [];

  try {
    originalProducts.forEach((originalProduct) => {
      const discountRequest = { product_id: originalProduct.id, user_id: '1' };
      promises.push(service.getDiscount(discountRequest));
    });

    res.json(await Promise.all(promises));
  } catch (e) {
    res.json(originalProducts);
  }
}

module.exports = getProductEndpoint;
