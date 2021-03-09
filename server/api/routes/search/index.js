const express = require('express');
const SearchService = require('../../../services/search/search');

const router = express.Router({
    // case sensitive routing
    caseSensitive: true
});

module.exports = (app) => {
    app.use('/search', router);

    const searchService = new SearchService();

    // get item information
    
}