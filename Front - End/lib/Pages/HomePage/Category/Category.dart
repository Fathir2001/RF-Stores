import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/category_provider.dart';
import '../Products/pantry.dart';
import '../Products/vegetables.dart';
import '../Products/dairy.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = context.watch<CategoryProvider>().categories;

    return Scaffold(
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: InkWell(
              onTap: () {
                if (category.title == 'Pantry Staples') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PantryPage()),
                  );
                } else if (category.title == 'Fresh Produce') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VegetablesPage()),
                  );
                } else if (category.title == 'Dairy and Eggs') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DairyPage()),
                  );
                }
              },
              child: Card(
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(category.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
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
                                category.title,
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
                                category.caption,
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
            ),
          );
        },
      ),
    );
  }
}
