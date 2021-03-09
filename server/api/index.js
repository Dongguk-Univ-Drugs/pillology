const router = require('express').Router({
    // case sensitive routing
    caseSensitive: true
});

// routes
const search = require('./routes/search');
const user =require('./routes/users');

module.exports = () => {
    const app = router;

    // routes
    search(app);
    user(app);

    return app;
}