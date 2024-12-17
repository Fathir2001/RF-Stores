import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'title': 'Pantry Staples', 'caption': 'Your kitchens foundation—everything you need for everyday cooking and more!'},
    {'title': 'Fresh Produce', 'caption': 'Straight from the farm to your table, fresh fruits, vegetables, and herbs to nourish your day.'},
    {'title': 'Dairy and Eggs', 'caption': 'The freshest milk, cheese, and eggs to keep your meals wholesome and delicious.'},
    {'title': 'Bakery', 'caption': 'Warm, fresh-baked delights to fill your home with the aroma of goodness.'},
    {'title': 'Snacks and Beverages', 'caption': 'Treat yourself to tasty snacks and refreshing drinks for every craving.'},
    {'title': 'Frozen Foods', 'caption': 'Quick, easy, and always ready—your go-to for frozen treats and meals.'},
    {'title': 'Household Essentials', 'caption': 'Everyday home necessities to keep your space clean, organized, and comfortable.'},
    {'title': 'Personal Care', 'caption': 'Pamper yourself with products that make you look and feel your best.'},
    {'title': 'Baby Products', 'caption': 'Gentle care and trusted products for your precious little one.'}
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

