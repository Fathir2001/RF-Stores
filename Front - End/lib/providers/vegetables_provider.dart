import 'package:flutter/foundation.dart';
import '../models/vegetables_model.dart';

class VegetablesProvider with ChangeNotifier {
  final List<VegetableItem> _items = [
    VegetableItem(
      name: 'Broccoli',
      price: 19.99,
      imageUrl: 'assets/images/vegetables/broccoli.jpg',
    ),
    VegetableItem(
      name: 'Carrot',
      price: 4.99, 
      imageUrl: 'assets/Images/vegetables/carrot.webp',
    ),
    VegetableItem(
      name: 'Garlic',
      price: 3.99,
      imageUrl: 'assets/Images/vegetables/garlic.webp',
    ),
    VegetableItem(
      name: 'Leeks',
      price: 2.99,
      imageUrl: 'assets/Images/vegetables/leeks.jpg',
    ),
    VegetableItem(
      name: 'Onion',
      price: 1.99,
      imageUrl: 'assets/Images/vegetables/onion.jpg',
    ),
    VegetableItem(
      name: 'Potato',
      price: 7.99,
      imageUrl: 'assets/Images/vegetables/potato.jpg',
    ),
  ];

  List<VegetableItem> get items => [..._items];
  final List<VegetableItem> _cartItems = [];
  List<VegetableItem> get cartItems => [..._cartItems];

  void addToCart(VegetableItem item) {
    _cartItems.add(item);
    notifyListeners();
  }
}