import 'package:flutter/foundation.dart' as flutter;
import '../models/category_model.dart';

class CategoryProvider with flutter.ChangeNotifier {
  final List<Category> _categories = [
    Category(
      title: 'Pantry Staples',
      caption: 'Your kitchens foundation—everything you need for everyday cooking and more!',
      image: 'assets/images/pantry_staples.jpg',
    ),
    Category(
      title: 'Fresh Produce',
      caption: 'Straight from the farm to your table, fresh fruits, vegetables, and herbs to nourish your day.',
      image: 'assets/images/fruits_vegetables.jpg'
    ),
    Category(
      title: 'Dairy and Eggs',
      caption: 'The freshest milk, cheese, and eggs to keep your meals wholesome and delicious.',
      image: 'assets/images/dairy_eggs.jpg'
    ),
    // Category(
    //   title: 'Bakery',
    //   caption: 'Warm, fresh-baked delights to fill your home with the aroma of goodness.',
    //   image: 'assets/images/bakery.jpg'
    // ),
    // Category(
    //   title: 'Snacks and Beverages',
    //   caption: 'Treat yourself to tasty snacks and refreshing drinks for every craving.',
    //   image: 'assets/images/snacks_beverages.jpg'
    // ),
    // Category(
    //   title: 'Frozen Foods',
    //   caption: 'Quick, easy, and always ready—your go-to for frozen treats and meals.',
    //   image: 'assets/images/frozen.jpg'
    // ),
    // Category(
    //   title: 'Household Essentials',
    //   caption: 'Everyday home necessities to keep your space clean, organized, and comfortable.',
    //   image: 'assets/images/household.webp'
    // ),
    // Category(
    //   title: 'Personal Care',
    //   caption: 'Pamper yourself with products that make you look and feel your best.',
    //   image: 'assets/images/personalcare.jpg'
    // ),
    // Category(
    //   title: 'Baby Products',
    //   caption: 'Gentle care and trusted products for your precious little one.',
    //   image: 'assets/images/baby.jpeg'
    // )
  ];

  List<Category> get categories => [..._categories];
}