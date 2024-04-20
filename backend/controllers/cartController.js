const cartService = require('../services/cartService');

exports.storeCartData = async (req, res) => {
  try {
    await cartService.storeCartData(req.body);
    res.status(200).json({ message: 'Cart data stored successfully' });
  } catch (error) {
    console.error('Error storing cart data:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
};
