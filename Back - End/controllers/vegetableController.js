const Vegetable = require('../models/vegetable');

const getVegetables = async (req, res) => {
  try {
    const vegetables = await Vegetable.find();
    res.status(200).json(vegetables);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

const updatePrice = async (req, res) => {
  try {
    const { id } = req.params;
    const { price } = req.body;
    const item = await Vegetable.findByIdAndUpdate(
      id,
      { price },
      { new: true }
    );
    res.status(200).json(item);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

module.exports = { getVegetables, updatePrice };