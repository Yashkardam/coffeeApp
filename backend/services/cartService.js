const CartItem = require('../model/cartItem');

exports.storeCartData = async (cartData) => {
  try {
    // Convert cartData to an array if it's not already an array
    const cartArray = Array.isArray(cartData) ? cartData : [cartData];

    // Save each cart item to MongoDB
    for (const item of cartArray) {
      const cartItem = new CartItem({
        name: item.name,
        price: item.price,
        imagePath: item.imagePath,
      });
      await cartItem.save();
    }
  } catch (error) {
    throw error;
  }
};