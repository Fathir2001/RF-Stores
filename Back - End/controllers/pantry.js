const PantryItem = require('../models/pantryItem');

const getItems = async (req, res) => {
  try {
    const items = await PantryItem.find();
    res.status(200).json(items);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

module.exports = { getItems };