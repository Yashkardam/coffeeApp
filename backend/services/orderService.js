const Order = require('../model/order_model');

exports.createOrder = async (userEmail, items) => {
  try {
    const order = new Order({ userEmail, items });
    return await order.save();
  } catch (error) {
    throw error;
  }
};