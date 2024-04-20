const mongoose = require('mongoose');
const db = require('../config/db');
const {Schema} = mongoose;
const userModel = require("../model/user_model");

const coffeeSchema = new Schema({
    name:{
        type:String,
        unique: true,
        required:true
    },
    price:{
        type:String,
        required:true
    },
    imgPath:{
        type:String,
        required:true,
        unique:true
    }
    
});


const coffeeModel = db.model('coffee',coffeeSchema)

module.exports = coffeeModel;