const router = require('express').Router();
const PillModel = require('../models/pillSchema');


var testIns = new PillModel({ pillname: "pills example" });
testIns.save(function (err, testIns) {
    if (err) return console.error(err);
    testIns.speak();
});

// find all
router.get('/', (req, res) => {
    PillModel.findAll()
        .then((result) => {
            if (!result.length)
                return res.status(404).send({ err: 'not found !' });
            res.send(result);
        })
        .catch((err) => res.status(500).send(err));
})

router.post('/pilldb', async (req, res) => {
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
        res.status(500).send('There was a problem registering your user');
    }
});


module.exports = router;