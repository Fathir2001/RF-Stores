const CartItem = require('../models/cart');

// Get all cart items for a user
exports.getCartItems = async (req, res) => {
  try {
    const userId = req.params.userId;
    const cartItems = await CartItem.find({ userId });
    res.json(cartItems);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Add item to cart
exports.addToCart = async (req, res) => {
  try {
    const { userId, productId, name, price, quantity, imageUrl } = req.body;
    
    // Check if item already exists in cart
    let cartItem = await CartItem.findOne({ userId, productId });
    
    if (cartItem) {
      // Update quantity if item exists
      cartItem.quantity += quantity;
      await cartItem.save();
    } else {
      // Create new cart item if it doesn't exist
      cartItem = new CartItem({
        userId,
        productId,
        name,
        price,
        quantity,
        imageUrl
      });
      await cartItem.save();
    }
    
    res.status(201).json(cartItem);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

// Update cart item quantity
exports.updateCartItem = async (req, res) => {
  try {
    const { quantity } = req.body;
    const cartItem = await CartItem.findById(req.params.id);
    
    if (!cartItem) {
      return res.status(404).json({ message: 'Cart item not found' });
    }
    
    cartItem.quantity = quantity;
    await cartItem.save();
    
    res.json(cartItem);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

// Remove item from cart
exports.removeFromCart = async (req, res) => {
  try {
    const cartItem = await CartItem.findByIdAndDelete(req.params.id);
    if (!cartItem) {
      return res.status(404).json({ message: 'Cart item not found' });
    }
    res.json({ message: 'Cart item removed' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Clear cart
exports.clearCart = async (req, res) => {
  try {
    const userId = req.params.userId;
    await CartItem.deleteMany({ userId });
    res.json({ message: 'Cart cleared successfully' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};