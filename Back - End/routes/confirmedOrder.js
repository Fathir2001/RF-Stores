const express = require("express");
const router = express.Router();
const {
  confirmOrder,
  getConfirmedOrders,
  deleteConfirmedOrder,
} = require("../controllers/confirmedOrderController");

router.put("/orders/:orderId/confirm", confirmOrder);
router.get("/confirmed-orders", getConfirmedOrders);
router.delete("/confirmed-orders/:orderId", deleteConfirmedOrder);

module.exports = router;