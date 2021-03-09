const dotenv = require('dotenv');

// available to read .env file
dotenv.config();

exports.config = { 
    port : process.env.PORT,
    databaseURI : process.env.MONGO_URI
}