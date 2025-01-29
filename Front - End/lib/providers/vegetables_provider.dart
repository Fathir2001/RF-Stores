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
}