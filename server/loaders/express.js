// dependencies
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

module.exports = async (app) => {

    app.get('/status', (req, res) => { res.status(200).end(); });
    app.head('/status', (req, res) => { res.status(200).end(); });
    app.enable('trust proxy');

    app.use(cors());
    app.use(bodyParser.urlencoded({ extended: false }));

    // use custom routes
    const routes = require('../api');
    app.use('/', routes());
    
    return app;
}
