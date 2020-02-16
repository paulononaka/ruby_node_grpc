const express = require('express');
const getInitialEndpoint = require('./index');
const getProductEndpoint = require('./products/index');

const router = express.Router();

router.get('/', getInitialEndpoint);
router.get('/product', getProductEndpoint);

module.exports = router;
