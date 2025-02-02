const express = require('express');
const router = express.Router();
const { getDairyItems, updatePrice } = require('../controllers/dairyController');

router.get('/', getDairyItems);
router.put('/:id/price', updatePrice);

module.exports = router;