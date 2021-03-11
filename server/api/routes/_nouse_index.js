const express = require('express');
const router = express.Router();

// search
const search = require('./search/index');
router.use('/search', search);

// user
const user = require('./users/index');
router.use('/user', user);

module.exports = router;

