const { ObjectID } = require('bson');
const mongoose = require('mongoose');

// define schemes
const imageSchema = new mongoose.Schema({
    //_id: { type: Number, required: true, unique: true },
    title: { type: String, required: true },
    url: { type: String, required: true },
    date: { type: String, required: true },
    category: { type: String, required: true },
    height: { type: Number, required: false }
});

// find all
// schema.statics.findAll = function () {
//     // return promise
//     return this.find({});
// }

// create model and export
module.exports = mongoose.model('Image', imageSchema);