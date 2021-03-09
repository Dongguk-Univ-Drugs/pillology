const expressLoader = require('./express');
const mongooseLoader = require('./mongoose');

module.exports = async ({ app }) => {
    // db
    mongooseLoader()
        .then((result) => {
            console.log("Mongo DB initialized");
        }).catch((err) => {
            console.error(err);
        });
    // express
    expressLoader({ app: app }).then((res) => console.log('Express initialized'));
}