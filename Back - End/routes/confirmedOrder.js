const express = require("express");
const router = express.Router();
const {
  confirmOrder,
  getConfirmedOrders,
  deleteConfirmedOrder,
  getTotalSales,
  getOrderCount,
  getTotalQuantity,
} = require("../controllers/confirmedOrderController");

router.put("/orders/:orderId/confirm", confirmOrder);
router.get("/confirmed-orders", getConfirmedOrders);
router.delete("/confirmed-orders/:orderId", deleteConfirmedOrder);
router.get("/total-sales", getTotalSales);
router.get("/order-count", getOrderCount);
router.get("/total-quantity", getTotalQuantity);

module.exports = router;