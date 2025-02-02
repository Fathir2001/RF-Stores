import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/dairy_model.dart';

class DairyProvider with ChangeNotifier {
  List<DairyItem> _items = [];

  List<DairyItem> get items => [..._items];

  Future<void> fetchDairyItems() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:5000/api/dairy'));

      if (response.statusCode == 200) {
        final List<dynamic> dairyJson = json.decode(response.body);
        _items = dairyJson
            .map((json) => DairyItem(
                  id: json['_id'],
                  name: json['name'],
                  price: json['price'].toDouble(),
                  imageUrl: json['imageUrl'],
                ))
            .toList();
        notifyListeners();
      }
    } catch (error) {
      print('Error fetching dairy items: $error');
      throw error;
    }
  }

  Future<void> updatePrice(String id, double price) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:5000/api/dairy/$id/price'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'price': price}),
      );

      if (response.statusCode == 200) {
        final updatedItem = json.decode(response.body);
        final index = _items.indexWhere((item) => item.id == id);
        if (index >= 0) {
          _items[index] = DairyItem.fromJson(updatedItem);
          notifyListeners();
        }
      }
    } catch (error) {
      print('Error updating dairy item price: $error');
      throw error;
    }
  }
}
