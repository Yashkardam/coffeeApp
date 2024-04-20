const mongoose = require('mongoose');
const db = require('../config/db');

const cartItemSchema = new mongoose.Schema({
  name: String,
  price: String,
  imagePath: String,
});

const CartItem = db.model('cart',cartItemSchema);


module.exports = CartItem;
