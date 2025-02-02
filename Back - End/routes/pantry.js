const express = require('express');
const router = express.Router();
const { getItems, updatePrice } = require('../controllers/pantry');

router.get('/items', getItems);
router.put('/items/:id/price', updatePrice);

module.exports = router;