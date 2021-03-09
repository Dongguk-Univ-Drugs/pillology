const Image = require('../../models/images/imageModel');

module.exports = class ImageService {
    // constructor
    constructor() { }

    // functions
    getAllImages = async () => {
        try {
            const res = await Image.find({});
            // console.log('res : '+ res);
            return { status: 200, result: res };
        } catch (err) {
            console.err(err);
            return { status: 500, result: err };
        }
    }
}