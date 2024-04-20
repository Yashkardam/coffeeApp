// controllers/coffeeController.js
const coffeeService = require('../services/addService');

async function AddCoffee(req, res, next) {
  try {
    const { name, price, imgPath } = req.body;
    const coffee = await coffeeService.addCoffee(name, price, imgPath);
    res.status(200).json({ success: true, coffee });
  } catch (error) {
    next(error);
  }
}

module.exports = { AddCoffee };