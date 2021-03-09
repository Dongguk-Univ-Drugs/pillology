// // env
// require('dotenv').config();
// // dependencies
// const express = require('express');

// const bodyparser = require('body-parser');
// // app
// const app = express();
// const port = process.env.PORT || 27017;

// // Static File Service
// app.use(express.static('public'));
// // Body-parser
// app.use(bodyparser.urlencoded({extended: true}));
// app.use(bodyparser.json());

// // use native promise from node.js
// mongoose.Promise = global.Promise;

// // connect to MONGODB SERVER
// mongoose.connect(process.env.MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true })
// .then(() => console.log('connected to mongodb !'))
// .catch((e) => console.error(e));

// // router
// const routes = require('./routes');

// app.use('/', routes);
// app.listen(port, () => console.log(`server listening on port ${port}`));

/**
 *       ver 1.0.1, 03.09.21
 *              - Using 3 layers Architecture
 *      
 *       Author. seunghwanly
 *  */
// TODO : es6 syntax not working ! - 03.09.21
// import config from './config';
const { config } = require('./config');
const init = require('./loaders');
const express = require('express');

const startServer = async () => {

    const app = express();

    await init(app);
    
    app.listen(config.port, err => {
        if (err) { console.error(err); return; }
        else console.log(`server listening on port ${config.port}`);
    });
}

startServer();