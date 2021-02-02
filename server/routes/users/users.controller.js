const PillModel = require('../../models/pillSchema');

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