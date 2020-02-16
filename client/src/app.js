const express = require('express');

const rootRouter = require('./api/router');

const app = express();
app.use(express.json());

app.use('/', rootRouter);

module.exports = app;
