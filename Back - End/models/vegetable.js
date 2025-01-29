const mongoose = require('mongoose');

const vegetableSchema = new mongoose.Schema({
  name: String,
  price: Number,
  imageUrl: String
});

module.exports = mongoose.model('Vegetables', vegetableSchema);