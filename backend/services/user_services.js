const UserModel= require('../model/user_model');
const jwt = require('jsonwebtoken');

class UserService{
    static async registerUser(email,password){
        try {
            const creatuser = new UserModel({email,password});
            return await creatuser.save();
        } catch (err) {
            throw err;
        }
    }

    static async checkuser(email){
        try {
            return await UserModel.findOne({email});
        } catch (error) {
            throw error
        }
    }
static async generateToken(tokenData,secretKey,jwt_expire){
    return jwt.sign(tokenData,secretKey,{expiresIn:jwt_expire});
}
}

module.exports = UserService