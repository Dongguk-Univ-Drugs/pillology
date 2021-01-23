// env
require('dotenv').config();
// dependencies
const express = require('express');
const mongoose = require('mongoose');
const bodyparser = require('body-parser');
// app
const app = express();
const port = process.env.PORT || 3000;

// Static File Service
app.use(express.static('public'));
// Body-parser
app.use(bodyparser.urlencoded({extended: true}));
app.use(bodyparser.json());

// use native promise from node.js
mongoose.Promise = global.Promise;

// connect to MONGODB SERVER
mongoose.connect(process.env.MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true })
.then(() => console.log('connected to mongodb !'))
.catch((e) => console.error(e));

// router
app.use('/index', require('./routes/index'));

app.listen(port, () => console.log(`server listening on port ${port}`));
