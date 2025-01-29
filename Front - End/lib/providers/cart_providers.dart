import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/cart_model.dart';

class CartProvider with ChangeNotifier {
  final String baseUrl = 'http://localhost:5000/api/cart';
  final String userId = 'user123'; // Replace with actual user ID from auth
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, item) {
      total += item.price * item.quantity;
    });
    return total;
  }

  Future<void> fetchCartItems() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$userId'));
      
      if (response.statusCode == 200) {
        final List<dynamic> cartData = json.decode(response.body);
        _items.clear();
        
        for (var item in cartData) {
          _items[item['productId']] = CartItem(
            id: item['_id'],
            name: item['name'],
            price: item['price'].toDouble(),
            imageUrl: item['imageUrl'],
            quantity: item['quantity'],
          );
        }
        notifyListeners();
      }
    } catch (error) {
      print('Error fetching cart items: $error');
      throw error;
    }
  }

  Future<void> addItem(String id, String name, double price, String imageUrl) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/add'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userId': userId,
          'productId': id,
          'name': name,
          'price': price,
          'imageUrl': imageUrl,
          'quantity': 1,
        }),
      );

      if (response.statusCode == 201) {
        await fetchCartItems();
      }
    } catch (error) {
      print('Error adding item to cart: $error');
      throw error;
    }
  }

  Future<void> removeItem(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/remove/$id'));
      
      if (response.statusCode == 200) {
        _items.remove(id);
        notifyListeners();
      }
    } catch (error) {
      print('Error removing item from cart: $error');
      throw error;
    }
  }

  Future<void> updateQuantity(String id, int quantity) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/update/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'quantity': quantity}),
      );

      if (response.statusCode == 200) {
        await fetchCartItems();
      }
    } catch (error) {
      print('Error updating cart item quantity: $error');
      throw error;
    }
  }

  Future<void> clear() async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/clear/$userId'));
      
      if (response.statusCode == 200) {
        _items.clear();
        notifyListeners();
      }
    } catch (error) {
      print('Error clearing cart: $error');
      throw error;
    }
  }
}