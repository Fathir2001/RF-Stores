import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PantryItem {
  final String name;
  final double price;
  final String imageUrl;

  PantryItem({
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory PantryItem.fromJson(Map<String, dynamic> json) {
    return PantryItem(
      name: json['name'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
    );
  }
}

class PantryProvider with ChangeNotifier {
  List<PantryItem> _items = [];

  List<PantryItem> get items => [..._items];

  Future<void> fetchItems() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:5000/api/pantry/items'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _items = data.map((item) => PantryItem.fromJson(item)).toList();
        notifyListeners();
      }
    } catch (error) {
      print('Error fetching items: $error');
      throw error;
    }
  }
}