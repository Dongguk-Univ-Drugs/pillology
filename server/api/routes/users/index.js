// const router = require('express').Router();
// const controller = require('./users.controller');

// router.get('/', controller.pills);
// router.route('/pilldb')
//     .post(controller.postPills);

// router.route('/pilldb/:id')
//     .put(controller.update)

// module.exports = router;


/**
 *  Update JungIn code to new structure 03.09.21
 */

const express = require('express');
const UserService = require('../../../services/user/user');
// const middlewares = require('../../middlewares');
// connect to services


const router = express.Router({
    // case sensitive routing
    caseSensitive: true
});

module.exports = (app) => {
    app.use('/user', router);

    const userService = new UserService();

    // get
    router.get('/', async (req, res) => {
        const { status, result } = await userService.findAllPills();
        if (status === 200) return res.send(result);
        else return res.status(status).send(result);
    });

    // post pill
    router.route('/pilldb').post(async (req, res) => {
        const { status, result } = await userService.postPills(req.body);
        if (status === 200) return res.send(result);
        else return res.status(status).send(result);
    })

    // update pill
    router.route('/pilldb/:id').put(async (req, res) => {
        const { status, result } = await userService.updatePills(req.params.id, req.body);
        if (status === 200) return res.send(result);
        else return res.status(status).send(result);
    })
}
