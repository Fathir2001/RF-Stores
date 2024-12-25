import 'package:flutter/foundation.dart';
import '../models/dairy_model.dart';

class DairyProvider with ChangeNotifier {
  final List<DairyItem> _items = [
    DairyItem(
      name: 'Broccoli',
      price: 19.99,
      imageUrl: 'assets/images/vegetables/broccoli.jpg',
    ),
    DairyItem(
      name: 'Carrot',
      price: 4.99, 
      imageUrl: 'assets/Images/vegetables/carrot.webp',
    ),
    DairyItem(
      name: 'Garlic',
      price: 3.99,
      imageUrl: 'assets/Images/vegetables/garlic.webp',
    ),
    DairyItem(
      name: 'Leeks',
      price: 2.99,
      imageUrl: 'assets/Images/vegetables/leeks.jpg',
    ),
    DairyItem(
      name: 'Onion',
      price: 1.99,
      imageUrl: 'assets/Images/vegetables/onion.jpg',
    ),
    DairyItem(
      name: 'Potato',
      price: 7.99,
      imageUrl: 'assets/Images/vegetables/potato.jpg',
    ),
  ];

  List<DairyItem> get items => [..._items];
  final List<DairyItem> _cartItems = [];
  List<DairyItem> get cartItems => [..._cartItems];

  void addToCart(DairyItem item) {
    _cartItems.add(item);
    notifyListeners();
  }
}