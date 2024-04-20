const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const db = require('../config/db');
const { type } = require('os');

const {Schema} = mongoose;

const userSchema = new Schema({
    email:{
        type:String,
        lowercase:true,
        unique: true,
        required:true
    },
    password:{
        type:String,
        required:true
    }
});

userSchema.pre('save',async function(){
    try {
        var user = this;
        const salt = await(bcrypt.genSalt(10));
        const hasspass = await bcrypt.hash(user.password,salt);

        user.password= hasspass;
    } catch (error) {
        throw error;
    }
});
userSchema.methods.comaparePassword = async function(userpassword){
    try {
        const isMatch = await bcrypt.compare(userpassword,this.password);
        return isMatch;
    } catch (error) {
        throw error;
    }
}


const userModel = db.model('user',userSchema)

module.exports = userModel;