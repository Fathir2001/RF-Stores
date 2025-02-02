const PantryItem = require('../models/pantryItem');

const getItems = async (req, res) => {
  try {
    const items = await PantryItem.find();
    res.status(200).json(items);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

const updatePrice = async (req, res) => {
  try {
    const { id } = req.params;
    const { price } = req.body;
    const item = await PantryItem.findByIdAndUpdate(
      id,
      { price },
      { new: true }
    );
    res.status(200).json(item);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

module.exports = { getItems, updatePrice };