const mongoose = require('mongoose');

const confirmedOrderItemSchema = new mongoose.Schema({
  itemName: {
    type: String,
    required: true
  },
  quantity: {
    type: Number,
    required: true
  },
  price: {
    type: Number,
    required: true
  },
  imageUrl: String
});

const confirmedOrderSchema = new mongoose.Schema({
  originalOrderId: {
    type: mongoose.Schema.Types.ObjectId,
    required: true,
    ref: 'Orders'
  },
  name: {
    type: String,
    required: true,
  },
  address: {
    type: String,
    required: true,
  },
  phone: {
    type: String,
    required: true,
  },
  orders: [confirmedOrderItemSchema],
  totalAmount: {
    type: Number,
    required: true,
  },
  confirmationDate: {
    type: Date,
    default: Date.now,
  },
  status: {
    type: String,
    default: 'completed'
  }
});

module.exports = mongoose.model('ConfirmedOrders', confirmedOrderSchema);