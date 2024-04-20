const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const orderSchema = new Schema({
  userEmail: {
    type: String,
    lowercase: true,
    required: true
  },
  items: [{
    name: {
      type: String,
      required: true
    },
    price: {
      type: String,
      required: true
    },
    imgPath: {
      type: String,
      required: true
    }
  }]
});

const Order = db.model('order', orderSchema);

module.exports = Order;