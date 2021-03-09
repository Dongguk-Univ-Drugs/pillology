const mongoose = require('mongoose');

// define schemes
const pillSchema = new mongoose.Schema({
    pillname: { 
        type: String, 
        required: true 
    },
    startDate: { 
        type: Date, 
        default: Date.now 
    },
    endDate: { 
        type: Date, 
        default: Date.now 
    },
    morningTime: { 
        type: String, 
        default: "9:00" 
    },
    afternoonTime: { 
        type: String, 
        default: "13:00" 
    },
    eveningTime: { 
        type: String, 
        default: "18:00" 
    },
    isMorningTimeSet: { 
        type: String 
    },
    isAfternoonTimeSet: { 
        type: String 
    },
    isEveningTimeSet: { 
        type: String 
    },
});

// 스키마 등록
module.exports = mongoose.model('Pill', pillSchema);
