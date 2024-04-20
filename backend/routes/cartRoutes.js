const express = require('express');
const router = express.Router();
const cartController = require('../controllers/cartController');

// Route to store cart data
router.post('/storeCartData', cartController.storeCartData);

module.exports = router;
