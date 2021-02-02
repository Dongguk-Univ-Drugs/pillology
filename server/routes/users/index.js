const router = require('express').Router();
const controller = require('./users.controller');

router.get('/', controller.pills);
router.post('/pilldb', controller.postPills);

module.exports = router;