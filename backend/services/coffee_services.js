const coffeeModel = require('../model/coffee_model');

class coffeeService{
    static async getCoffees(){
        const coffeeData = await coffeeModel.find({});
        return await coffeeData;
    }
}

module.exports = coffeeService;