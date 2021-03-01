const { ObjectID } = require('bson');
var mongoose = require('mongoose');
var Schema = mongoose.Schema;

// define schemes
var pillSchema = new mongoose.Schema({
    pillname: { type: String, required: true },
    startDate: { type: Date, default: Date.now },
    endDate: { type: Date, default: Date.now },
    morningTime: { type: String, default: "9:00" },
    afternoonTime: { type: String, default: "13:00" },
    eveningTime: { type: String, default: "18:00" },
    isMorningTimeSet: { type: String },
    isAfternoonTimeSet: { type: String },
    isEveningTimeSet: { type: String },
});

// find all
pillSchema.statics.findAll = function () {
    // return promise
    return this.find({});
}

// Create new pill document
pillSchema.statics.create = function (payload) {
    // this === Model
    const pill = new this(payload);
    console.log("completed!!");
    // return Promise
    return pill.save();
};

pillSchema.methods.speak = function () {
    var pillname = this.pillname
        ? this.pillname
        : "No pillname"
    console.log(pillname);
}

// create model and export
// module.exports = mongoose.model('images', schema);
//스키마 등록
module.exports = mongoose.model('Pill', pillSchema);
