const router = require('express').Router();
const controller = require('./users.controller');

router.get('/', controller.pills);
router.post('/pilldb', controller.postPills);

router.route('/pilldb/:id')
    .get(controller.view)
    .put(controller.update)

module.exports = router;