const { get } = require('mongoose');
const { collection } = require('../../models/pillSchema');
const PillModel = require('../../models/pillSchema');

exports.users = (req, res, next) => {
    res.send('respond with a resource');
}

exports.pills = (req, res) => {
    PillModel.findAll()
        .then((result) => {
            if (!result.length)
                return res.status(404).send({ err: 'not found !' });
            res.send(result);
        })
        .catch((err) => res.status(500).send(err));
}
exports.postPills = async (req, res) => {
    try {
        const { pillname, startDate, endDate, morningTime, afternoonTime, eveningTime,
            isMorningTimeSet, isAfternoonTimeSet, isEveningTimeSet } = req.body;

        const pill = new PillModel({
            pillname: pillname,
            startDate: startDate, endDate: endDate, morningTime: morningTime, afternoonTime: afternoonTime, eveningTime: eveningTime,
            isMorningTimeSet: isMorningTimeSet, isAfternoonTimeSet: isAfternoonTimeSet, isEveningTimeSet: isEveningTimeSet
        });
        await PillModel.create(pill);

    } catch (e) {
        console.log(e)
        res.status(500).send('There was a problem posting pill info');
    }
}

exports.update = (req, res) => {

    PillModel.findById(req.params.id, function (err, result) {
        if (err){
            res.json({
                status: 'err',
                code: 500,
                message: err
            })
        }
        console.log(req.params.id);
        result.pillname = req.body.pillname
        result.startDate = req.body.startDate
        result.endDate = req.body.endDate
        result.isMorningTimeSet = req.body.isMorningTimeSet
        result.isAfternoonTimeSet = req.body.isAfternoonTimeSet
        result.isEveningTimeSet = req.body.isEveningTimeSet
        result.morningTime = req.body.morningTime
        result.afternoonTime = req.body.afternoonTime
        result.eveningTime = req.body.eveningTime

        result.save(function (err) {
            if (err)
                res.json({
                    status: 'err',
                    code: 500,
                    message: err
                })
            res.json(result);
        })
    })
}
/*
exports.condition = (req, res) => {
    PillModel.find({ pillname: req.body.pillname})
        .then((result) => {
            if (!result.length)
                return res.status(404).send({ err: 'not found !' });
            res.json(result);
        })
        .catch((err) => res.status(500).send(err));
}
exports.view = function (req, res) {
    PillModel.findById(req.params.id, function (err, result) {
        if (err) {
            console.log(err);
        }
        res.json(result);
    })
}
*/