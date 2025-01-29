const mongoose = require('mongoose');

const dairySchema = new mongoose.Schema({
  name: String,
  price: Number,
  imageUrl: String
});

module.exports = mongoose.model('DairyItems', dairySchema);