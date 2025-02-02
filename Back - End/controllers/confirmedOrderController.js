const ConfirmedOrder = require("../models/confirmedOrder");
const Customer = require("../models/Order");

exports.confirmOrder = async (req, res) => {
  try {
    const { orderId } = req.params;

    // Find original order
    const originalOrder = await Customer.findById(orderId);
    if (!originalOrder) {
      return res.status(404).json({
        success: false,
        error: "Original order not found",
      });
    }

    // Create confirmed order
    const confirmedOrder = new ConfirmedOrder({
      originalOrderId: originalOrder._id,
      name: originalOrder.name,
      address: originalOrder.address,
      phone: originalOrder.phone,
      orders: originalOrder.orders,
      totalAmount: originalOrder.totalAmount,
    });

    // Save confirmed order
    await confirmedOrder.save();

    // Delete original order
    await Customer.findByIdAndDelete(orderId);

    res.status(200).json({
      success: true,
      data: confirmedOrder,
    });
  } catch (error) {
    console.error("Error confirming order:", error);
    res.status(500).json({
      success: false,
      error: error.message,
    });
  }
};

exports.getConfirmedOrders = async (req, res) => {
  try {
    const confirmedOrders = await ConfirmedOrder.find()
      .sort({ confirmationDate: -1 });
    res.status(200).json({
      success: true,
      data: confirmedOrders,
    });
  } catch (error) {
    console.error("Error getting confirmed orders:", error);
    res.status(500).json({
      success: false,
      error: error.message,
    });
  }
};

exports.deleteConfirmedOrder = async (req, res) => {
  try {
    const { orderId } = req.params;
    const deletedOrder = await ConfirmedOrder.findByIdAndDelete(orderId);
    
    if (!deletedOrder) {
      return res.status(404).json({
        success: false,
        error: "Confirmed order not found",
      });
    }

    res.status(200).json({
      success: true,
      data: {},
    });
  } catch (error) {
    console.error("Error deleting confirmed order:", error);
    res.status(500).json({
      success: false,
      error: error.message,
    });
  }
};


exports.getTotalSales = async (req, res) => {
  try {
    const result = await ConfirmedOrder.aggregate([
      {
        $group: {
          _id: null,
          totalSales: { $sum: "$totalAmount" }
        }
      }
    ]);

    const totalSales = result.length > 0 ? result[0].totalSales : 0;

    res.status(200).json({
      success: true,
      data: { totalSales }
    });
  } catch (error) {
    console.error("Error calculating total sales:", error);
    res.status(500).json({
      success: false,
      error: error.message
    });
  }
};