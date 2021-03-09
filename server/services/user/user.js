// for user services
const Pill = require("../../models/user/pillModel");

module.exports = class UserService {
    // constructor
    constructor() { }

    // functions
    getUsers = () => {
        try {
            return { status: 200, result: 'Success' };
        } catch (err) {
            console.error(err);
            return { status: 500, result: err };
        }
    }

    // findPills
    findAllPills = async () => {
        try {
            const res = await Pill.find({});
            return { status: 200, result: res };
        } catch (err) {
            console.err(err);
            return { status: 500, result: err };
        }

    }
    // post
    postPills = async (body) => {
        try {
            const { pillname, startDate, endDate, morningTime, afternoonTime, eveningTime,
                isMorningTimeSet, isAfternoonTimeSet, isEveningTimeSet } = body;

            // create new model
            const newPill = await Pill.create({
                pillname: pillname,
                startDate: startDate,
                endDate: endDate,
                morningTime: morningTime,
                afternoonTime: afternoonTime,
                eveningTime: eveningTime,
                isMorningTimeSet: isMorningTimeSet,
                isAfternoonTimeSet: isAfternoonTimeSet,
                isEveningTimeSet: isEveningTimeSet
            });
            await newPill.save();
            return { status: 200, result: "Save completed!" };
        } catch (err) {
            console.error(err);
            return { status: 500, result: 'There was a problem posting pill info' };
        }
    }

    // update
    updatePills = async (id, body) => {
        try {
            await Pill.findByIdAndUpdate(id, {
                // update query
                pillname: body.pillname,
                startDate: body.startDate,
                endDate: body.endDate,
                isMorningTimeSet: body.isMorningTimeSet,
                isAfternoonTimeSet: body.isAfternoonTimeSet,
                isEveningTimeSet: body.isEveningTimeSet,
                morningTime: morningTime,
                afternoonTime: afternoonTime,
                eveningTime: body.eveningTime
            }, (err, result) => {
                if (err) return { status: 500, result: err };
                return { status: 200, result: result };
            })
        } catch (err) {
            console.err(err);
            return { status: 500, result: 'There was a problem posting pill info' };
        }
    }
}