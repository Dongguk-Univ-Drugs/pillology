const { ObjectID } = require('bson');
var mongoose = require('mongoose');
var Schema = mongoose.Schema;

// define schemes
var conditionSchema = new mongoose.Schema({
    condition: { type: String },
});


// find all
conditionSchema.statics.findAll = function () {
    // return promise
    return this.find({});
}

// Create new pill document
conditionSchema.statics.create = function (payload) {
    // this === Model
    const condition = new this(payload);
    console.log("completed!!");
    // return Promise
    return pill.save();
};

// create model and export
// module.exports = mongoose.model('images', schema);
//스키마 등록
module.exports = mongoose.model('Condition', conditionSchema);
