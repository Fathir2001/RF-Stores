const Customer = require('../models/customer');

exports.createOrder = async (req, res) => {
  try {
    console.log('Received order data:', req.body); // Add logging

    const { name, address, phone, orders, totalAmount } = req.body;

    const customer = new Customer({
      name,
      address,
      phone,
      orders,
      totalAmount,
    });

    console.log('Created customer object:', customer); // Add logging

    const savedCustomer = await customer.save();
    console.log('Saved customer:', savedCustomer); // Add logging

    res.status(201).json({
      success: true,
      data: savedCustomer,
    });
  } catch (error) {
    console.error('Error creating order:', error); // Add error logging
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