const express = require('express');
const getInitialEndpoint = require('./api/index');
const getProductEndpoint = require('./api/products/index');

const app = express();
app.use(express.json());
app.get('/', getInitialEndpoint);
app.get('/product', getProductEndpoint);

module.exports = app;
