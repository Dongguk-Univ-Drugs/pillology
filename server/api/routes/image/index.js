const express = require('express');
const ImageService = require('../../../services/image/image');

const router = express.Router({
    // case sensitive routing
    caseSensitive: true
});

module.exports = (app) => {
    app.use('/images', router);

    const imageService = new ImageService();

    router.get('/', async (req, res) => {
        const { status, result } = await imageService.getAllImages();
        
        if (status === 200) return res.send(result);
        else return res.status(status).send(result);
    });
}