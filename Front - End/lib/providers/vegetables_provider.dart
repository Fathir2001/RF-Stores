import 'package:flutter/foundation.dart';
import '../models/vegetables_model.dart';

class VegetablesProvider with ChangeNotifier {
  final List<VegetableItem> _items = [
    VegetableItem(
      name: 'Rice',
      price: 19.99,
      imageUrl: 'assets/images/pantry/rice.jpeg',
    ),
    VegetableItem(
      name: 'Pasta',
      price: 4.99, 
      imageUrl: 'assets/Images/pantry/pasta.jpg',
    ),
    VegetableItem(
      name: 'Flour',
      price: 3.99,
      imageUrl: 'assets/Images/pantry/flour.jpg',
    ),
    VegetableItem(
      name: 'Sugar',
      price: 2.99,
      imageUrl: 'assets/Images/pantry/sugar.jpeg',
    ),
    VegetableItem(
      name: 'Salt',
      price: 1.99,
      imageUrl: 'assets/Images/pantry/salt.jpg',
    ),
    VegetableItem(
      name: 'Oats',
      price: 7.99,
      imageUrl: 'assets/Images/pantry/oats.webp',
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