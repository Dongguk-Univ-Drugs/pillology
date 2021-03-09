// dependecies
const mongoose = require('mongoose');
// env
const { config } = require('../config');

module.exports = async () => {
    // use native promise from node.js
    mongoose.Promise = global.Promise;
    
    const connect = await mongoose.connect(config.databaseURI, { useNewUrlParser: true, useUnifiedTopology: true });

    return connect.connection.db;
}