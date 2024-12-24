import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {
      'title': 'Pantry Staples',
      'caption': 'Your kitchens foundation—everything you need for everyday cooking and more!',
      'image': 'assets/images/pantry_staples.jpg'
    },
    {
      'title': 'Fresh Produce',
      'caption': 'Straight from the farm to your table, fresh fruits, vegetables, and herbs to nourish your day.',
      'image': 'assets/images/fruits_vegetables.jpg'
    },
    {
      'title': 'Dairy and Eggs',
      'caption': 'The freshest milk, cheese, and eggs to keep your meals wholesome and delicious.',
      'image': 'assets/images/dairy_eggs.jpg'
    },
    {
      'title': 'Bakery',
      'caption': 'Warm, fresh-baked delights to fill your home with the aroma of goodness.',
      'image': 'assets/images/bakery.jpg'
    },
    {
      'title': 'Snacks and Beverages',
      'caption': 'Treat yourself to tasty snacks and refreshing drinks for every craving.',
      'image': 'assets/images/snacks_beverages.jpg'
    },
    {
      'title': 'Frozen Foods',
      'caption': 'Quick, easy, and always ready—your go-to for frozen treats and meals.',
      'image': 'assets/images/frozen.jpg'
    },
    {
      'title': 'Household Essentials',
      'caption': 'Everyday home necessities to keep your space clean, organized, and comfortable.',
      'image': 'assets/images/household.webp'
    },
    {
      'title': 'Personal Care',
      'caption': 'Pamper yourself with products that make you look and feel your best.',
      'image': 'assets/images/personalcare.jpg'
    },
    {
      'title': 'Baby Products',
      'caption': 'Gentle care and trusted products for your precious little one.',
      'image': 'assets/images/baby.jpeg'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Card(
              elevation: 4,
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  // Background Image
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(categories[index]['image']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Left-side Gradient Overlay
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.black.withOpacity(0.9),
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.4, 0.8],
                      ),
                    ),
                  ),
                  // Content
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              categories[index]['title']!,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    blurRadius: 3,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              categories[index]['caption']!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                height: 1.3,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    blurRadius: 3,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}