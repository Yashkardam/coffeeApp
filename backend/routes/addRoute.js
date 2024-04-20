// routes/coffeeRoutes.js
const express = require('express');
const router = express.Router();
const coffeeController = require('../controllers/addController');

router.post('/add', coffeeController.AddCoffee);

module.exports = router;