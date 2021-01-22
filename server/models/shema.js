const { ObjectID } = require('bson');
const mongoose = require('mongoose');

// define schemes
const schema = new mongoose.Schema({
    _id : { type: ObjectID, required: true, unique:true },
    title : { type: String, required: true },
    url: { type: String, required: true }
});

// find all
schema.statics.findAll = function() {
    // return promise
    return this.find({});
};

// create model and export
module.exports = mongoose.model('images', schema);