import 'package:flutter/foundation.dart';
import '../models/pantry_model.dart';

class PantryProvider with ChangeNotifier {
  final List<PantryItem> _items = [
    PantryItem(
      name: 'Rice',
      price: 19.99,
      imageUrl: 'assets/images/pantry/rice.jpeg',
    ),
    PantryItem(
      name: 'Pasta',
      price: 4.99, 
      imageUrl: 'assets/Images/pantry/pasta.jpg',
    ),
    PantryItem(
      name: 'Flour',
      price: 3.99,
      imageUrl: 'assets/Images/pantry/flour.jpg',
    ),
    PantryItem(
      name: 'Sugar',
      price: 2.99,
      imageUrl: 'assets/Images/pantry/sugar.jpeg',
    ),
    PantryItem(
      name: 'Salt',
      price: 1.99,
      imageUrl: 'assets/Images/pantry/salt.jpg',
    ),
    PantryItem(
      name: 'Oats',
      price: 7.99,
      imageUrl: 'assets/Images/pantry/oats.webp',
    ),
  ];

  List<PantryItem> get items => [..._items];
  
}