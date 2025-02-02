const express = require("express");
const router = express.Router();
const Customer = require("../models/Order");
const { createOrder, getAllOrders, deleteOrder} = require("../controllers/orderController");

router.post("/order", createOrder);

router.get("/orders", getAllOrders);

router.delete("/orders/:orderId", deleteOrder);

module.exports = router;
