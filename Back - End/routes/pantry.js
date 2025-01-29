const express = require('express');
const router = express.Router();
const { getItems } = require('../controllers/pantry');

router.get('/items', getItems);

module.exports = router;