const express = require('express');
const router = express.Router();
const cartController = require('../controllers/cartController');

// Get all cart items for a user
router.get('/:userId', cartController.getCartItems);

// Add item to cart
router.post('/add', cartController.addToCart);

// Update cart item quantity
router.put('/update/:id', cartController.updateCartItem);

// Remove item from cart
router.delete('/remove/:id', cartController.removeFromCart);

// Clear cart
router.delete('/clear/:userId', cartController.clearCart);

module.exports = router;