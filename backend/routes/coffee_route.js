const router = require('express').Router();
const coffeeController = require("../controllers/coffee_controller");

router.get('/getCoffee',coffeeController.getCoffee);

module.exports = router;