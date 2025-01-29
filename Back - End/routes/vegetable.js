const express = require('express');
const router = express.Router();
const { getVegetables } = require('../controllers/vegetableController');

router.get('/', getVegetables);

module.exports = router;