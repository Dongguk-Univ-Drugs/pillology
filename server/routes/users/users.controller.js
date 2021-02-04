const PillModel = require('../../models/pillSchema');
var getData = function (result){
    var data = {
        'pillname': result.pillname
    }
    return data;
}
function getCurrentDate() {
    var date = new Date();
    var year = date.getFullYear();
    var month = date.getMonth();
    var today = date.getDate();
    var hours = date.getHours();
    var minutes = date.getMinutes();
    var seconds = date.getSeconds();
    var milliseconds = date.getMilliseconds();
    return new Date(Date.UTC(year, month, today, hours, minutes, seconds, milliseconds));
}

exports.users = (req, res, next) => {
    res.send('respond with a resource');
}

// find all
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
        await pill.save();
    } catch (e) {
        console.log(e)
        res.status(500).send('There was a problem posting pill info');
    }
}
exports.condition = async (req, res) => {
    try {
        console.log('Request Id:', req.params.id);

    } catch (e) {
        console.log(e)
        res.status(500).send('id error');
    }
}