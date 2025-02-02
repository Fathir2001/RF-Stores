const express = require("express");
const router = express.Router();
const Customer = require("../models/Order");
const { createOrder, getAllOrders } = require("../controllers/orderController");

// Create new order
router.post("/order", createOrder);

// Get all orders
router.get("/orders", getAllOrders);

module.exports = router;
