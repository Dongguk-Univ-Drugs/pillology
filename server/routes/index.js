const router = require('express').Router();
const model = require('../models/shema');

// find all
router.get('/', (req, res) => {
    model.findAll()
        .then((result) => {
            if (!result.length)
                return res.status(404).send({ err: 'not found !' });
            res.send(result);
        })
        .catch((err) => res.status(500).send(err));
})

module.exports = router;