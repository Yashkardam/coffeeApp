// controllers/orderController.js
const orderService = require('../services/orderService');

exports.createOrder = async (req, res) => {
  try {
    const { userEmail, items } = req.body;
    const order = await orderService.createOrder(userEmail, items);
    res.status(201).json(order);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
