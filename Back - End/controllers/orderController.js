const Customer = require("../models/Order");

exports.createOrder = async (req, res) => {
  try {
    console.log("Received order data:", req.body);
    console.log("Received orders array:", req.body.orders); // Add this line

    const { name, address, phone, orders, totalAmount } = req.body;

    // Validate orders array
    if (!orders || !Array.isArray(orders) || orders.length === 0) {
      return res.status(400).json({
        success: false,
        error: "Orders array is required and must not be empty",
      });
    }

    // Validate each order item
    const validOrders = orders.map((order) => ({
      itemName: order.itemName,
      quantity: order.quantity,
      price: order.price,
      imageUrl: order.imageUrl,
    }));

    const customer = new Customer({
      name,
      address,
      phone,
      orders: validOrders, // Use validated orders
      totalAmount,
    });

    console.log("Customer object before save:", customer);

    const savedCustomer = await customer.save();
    console.log("Saved customer:", savedCustomer);

    res.status(201).json({
      success: true,
      data: savedCustomer,
    });
  } catch (error) {
    console.error("Error creating order:", error);
    res.status(500).json({
      success: false,
      error: error.message,
    });
  }
};
exports.getAllOrders = async (req, res) => {
  try {
    const orders = await Customer.find().sort({ orderDate: -1 });
    res.status(200).json({
      success: true,
      data: orders,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: error.message,
    });
  }
};

exports.deleteOrder = async (req, res) => {
  try {
    const { orderId } = req.params;
    const deletedOrder = await Customer.findByIdAndDelete(orderId);
    
    if (!deletedOrder) {
      return res.status(404).json({
        success: false,
        error: 'Order not found'
      });
    }

    res.status(200).json({
      success: true,
      data: deletedOrder
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: error.message
    });
  }
};
