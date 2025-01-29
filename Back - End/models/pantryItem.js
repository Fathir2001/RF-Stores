const mongoose = require('mongoose');

const pantryItemSchema = new mongoose.Schema({
  name: String,
  price: Number,
  imageUrl: String
});

module.exports = mongoose.model('PantryItem', pantryItemSchema);