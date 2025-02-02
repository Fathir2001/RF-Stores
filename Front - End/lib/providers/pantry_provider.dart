import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/pantry_model.dart';

class PantryProvider with ChangeNotifier {
  List<PantryItem> _items = [];

  List<PantryItem> get items => [..._items];

  Future<void> fetchItems() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:5000/api/pantry/items')
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _items = data.map((json) => PantryItem(
          id: json['_id'],
          name: json['name'],
          price: json['price'].toDouble(),
          imageUrl: json['imageUrl'],
        )).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load pantry items');
      }
    } catch (error) {
      print('Error fetching items: $error');
      throw error;
    }
  }

  Future<void> updatePrice(String id, double price) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:5000/api/pantry/items/$id/price'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'price': price}),
      );
      
      if (response.statusCode == 200) {
        final updatedItem = json.decode(response.body);
        final index = _items.indexWhere((item) => item.id == id);
        if (index >= 0) {
          _items[index] = PantryItem(
            id: updatedItem['_id'],
            name: updatedItem['name'],
            price: updatedItem['price'].toDouble(),
            imageUrl: updatedItem['imageUrl'],
          );
          notifyListeners();
        }
      } else {
        throw Exception('Failed to update price');
      }
    } catch (error) {
      print('Error updating pantry item price: $error');
      throw error;
    }
  }
}