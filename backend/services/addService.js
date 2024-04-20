// services/coffeeService.js
const Coffee = require('../model/coffee_model');

async function addCoffee(name, price, imgPath) {
  try {
    // Create a new coffee instance
    const coffee = new Coffee({
      name,
      price,
      imgPath,
    });
    
    // Save the coffee to the database
    await coffee.save();
    
    return coffee;
  } catch (error) {
    throw error;
  }
}

module.exports = { addCoffee };