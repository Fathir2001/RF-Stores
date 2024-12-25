import 'package:flutter/foundation.dart';
import '../models/dairy_model.dart';

class DairyProvider with ChangeNotifier {
  final List<DairyItem> _items = [
    DairyItem(
      name: 'Butter',
      price: 19.99,
      imageUrl: 'assets/images/dairy&eggs/butter.jpg',
    ),
    DairyItem(
      name: 'Cheese',
      price: 4.99, 
      imageUrl: 'assets/Images/dairy&eggs/cheese.jpg',
    ),
    DairyItem(
      name: 'Egg',
      price: 3.99,
      imageUrl: 'assets/Images/dairy&eggs/eggs.webp',
    ),
    DairyItem(
      name: 'Ghee',
      price: 2.99,
      imageUrl: 'assets/Images/dairy&eggs/ghee.jpeg',
    ),
    DairyItem(
      name: 'Milk',
      price: 1.99,
      imageUrl: 'assets/Images/dairy&eggs/milk.jpeg',
    ),
    DairyItem(
      name: 'Yoghurt',
      price: 7.99,
      imageUrl: 'assets/Images/dairy&eggs/yoghurt.png',
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