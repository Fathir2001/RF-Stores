const express = require('express');
const router = express.Router();
const { getVegetables, updatePrice } = require('../controllers/vegetableController');

router.get('/', getVegetables);
router.put('/:id/price', updatePrice);

module.exports = router;