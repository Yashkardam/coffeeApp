const coffeeService = require('../services/coffee_services');
const cofeeService = require('../services/coffee_services');

exports.getCoffee = async (req,res,next)=>{

    try {
        let coffeeInfo = await coffeeService.getCoffees();
        res.json({status:true,success:coffeeInfo});
    } catch (error) {
        next(error);
    }
}