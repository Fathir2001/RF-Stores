import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/dairy_model.dart';

class DairyProvider with ChangeNotifier {
  List<DairyItem> _items = [];

  List<DairyItem> get items => [..._items];

  Future<void> fetchDairyItems() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:5000/api/dairy'));
      
      if (response.statusCode == 200) {
        final List<dynamic> dairyJson = json.decode(response.body);
        _items = dairyJson.map((json) => DairyItem(
          name: json['name'],
          price: json['price'].toDouble(),
          imageUrl: json['imageUrl'],
        )).toList();
        notifyListeners();
      }
    } catch (error) {
      print('Error fetching dairy items: $error');
      throw error;
    }
  }
}