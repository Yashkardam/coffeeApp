const mongoose = require('mongoose');

const connection = mongoose.createConnection('mongodb://127.0.0.1:27017/users');

module.exports = connection;