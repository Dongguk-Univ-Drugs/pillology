const router = require('express').Router();
const controller = require('./users.controller');

router.get('/', controller.pills);
router.route('/pilldb')
    .post(controller.postPills);

router.route('/pilldb/:id')
    .put(controller.update)

module.exports = router;