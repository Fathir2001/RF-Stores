const express = require('express');
const router = express.Router();
const { getDairyItems } = require('../controllers/dairyController');

router.get('/', getDairyItems);

module.exports = router;