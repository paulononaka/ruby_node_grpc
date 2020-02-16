const express = require('express');
const getInitialEndpoint = require('./');

const router = express.Router();

router.get('/', getInitialEndpoint);

module.exports = router;
