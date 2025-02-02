const express = require('express');
const router = express.Router();
const { createOrder, getAllOrders } = require('../controllers/customerController');

// Create new order
router.post('/order', createOrder);

// Get all orders
router.get('/orders', getAllOrders);

module.exports = router;