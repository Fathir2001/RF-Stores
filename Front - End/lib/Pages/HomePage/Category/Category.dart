import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'title': 'Pantry Staples', 'caption': 'Essential pantry items'},
    {'title': 'Fresh Produce', 'caption': 'Fresh fruits and vegetables'},
    {'title': 'Dairy and Eggs', 'caption': 'Milk, cheese, and eggs'},
    {'title': 'Bakery', 'caption': 'Bread, cakes, and pastries'},
    {'title': 'Snacks and Beverages', 'caption': 'Chips, drinks, and more'},
    {'title': 'Frozen Foods', 'caption': 'Frozen meals and desserts'},
    {'title': 'Household Essentials', 'caption': 'Cleaning supplies and more'},
    {'title': 'Personal Care', 'caption': 'Toiletries and personal care items'},
    {'title': 'Baby Products', 'caption': 'Baby food and diapers'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(categories[index]['title']!),
              subtitle: Text(categories[index]['caption']!),
            ),
          );
        },
      ),
    );
  }
}

