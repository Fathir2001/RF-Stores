import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/vegetables_model.dart';

class VegetablesProvider with ChangeNotifier {
  List<VegetableItem> _items = [];

  List<VegetableItem> get items => [..._items];

  Future<void> fetchVegetables() async {
  try {
    final response = await http.get(Uri.parse('http://localhost:5000/api/vegetables'));
    
    if (response.statusCode == 200) {
      final List<dynamic> vegetablesJson = json.decode(response.body);
      _items = vegetablesJson.map((json) => VegetableItem(
        id: json['_id'],
        name: json['name'],
        price: json['price'].toDouble(),
        imageUrl: json['imageUrl'],
      )).toList();
      notifyListeners();
    }
  } catch (error) {
    print('Error fetching vegetables: $error');
    throw error;
  }
}

    
  Future<void> updatePrice(String id, double price) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:5000/api/vegetables/$id/price'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'price': price}),
      );
      
      if (response.statusCode == 200) {
        final updatedItem = json.decode(response.body);
        final index = _items.indexWhere((item) => item.id == id);
        if (index >= 0) {
          _items[index] = VegetableItem.fromJson(updatedItem);
          notifyListeners();
        }
      }
    } catch (error) {
      print('Error updating vegetable price: $error');
      throw error;
    }
  }

}