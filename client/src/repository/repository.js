const requireDir = require('require-dir');

const products = requireDir('../../../data/Products');

function getProducts() {
  Object.keys(products).forEach((id) => {
    products[id].id = id;
    products[id].discount = { pct: 0, value_in_cents: 0 };
  });
  return Object.values(products);
}

module.exports = { getProducts };
