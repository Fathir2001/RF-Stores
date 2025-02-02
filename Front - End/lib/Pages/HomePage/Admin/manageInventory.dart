import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/pantry_provider.dart';
import '../../../providers/vegetables_provider.dart';
import '../../../providers/dairy_provider.dart';

class ManageInventoryPage extends StatefulWidget {
  @override
  _ManageInventoryPageState createState() => _ManageInventoryPageState();
}

class _ManageInventoryPageState extends State<ManageInventoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Fetch pantry items when page loads
    Provider.of<PantryProvider>(context, listen: false).fetchItems();
    Provider.of<VegetablesProvider>(context, listen: false).fetchVegetables();
    Provider.of<DairyProvider>(context, listen: false).fetchDairyItems();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _editPrice(
      BuildContext context, dynamic item, String type) async {
    final TextEditingController priceController = TextEditingController(
      text: item.price.toString(),
    );

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Price'),
        content: TextField(
          controller: priceController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'New Price',
            prefixText: '\$',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              double? newPrice = double.tryParse(priceController.text);
              if (newPrice != null) {
                switch (type) {
                  case 'pantry':
                    Provider.of<PantryProvider>(context, listen: false)
                        .updatePrice(item.id, newPrice);
                    break;
                  case 'vegetables':
                    Provider.of<VegetablesProvider>(context, listen: false)
                        .updatePrice(item.id, newPrice);
                    break;
                  case 'dairy':
                    Provider.of<DairyProvider>(context, listen: false)
                        .updatePrice(item.id, newPrice);
                    break;
                }
                Navigator.pop(context);
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildPantryGrid() {
    return Consumer<PantryProvider>(
      builder: (context, pantryProvider, child) {
        final items = pantryProvider.items;

        return GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(item.imageUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(4)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text('\$${item.price.toStringAsFixed(2)}'),
                            IconButton(
                              icon: Icon(Icons.edit, size: 16),
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              onPressed: () =>
                                  _editPrice(context, item, 'pantry'),
                            ),
                          ],
                        ),
                        // You can add stock information here if available in your model
                        // Text('Stock: ${item.stock}'),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildVegetablesGrid() {
    return Consumer<VegetablesProvider>(
      builder: (context, vegetablesProvider, child) {
        final items = vegetablesProvider.items;

        return GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(item.imageUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(4)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text('\$${item.price.toStringAsFixed(2)}'),
                            IconButton(
                              icon: Icon(Icons.edit, size: 16),
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              onPressed: () =>
                                  _editPrice(context, item, 'vegetables'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDairyGrid() {
    return Consumer<DairyProvider>(
      builder: (context, dairyProvider, child) {
        final items = dairyProvider.items;

        return GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(item.imageUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(4)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text('\$${item.price.toStringAsFixed(2)}'),
                            IconButton(
                              icon: Icon(Icons.edit, size: 16),
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              onPressed: () =>
                                  _editPrice(context, item, 'dairy'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Inventory'),
        backgroundColor: Colors.green[800],
      ),
      body: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 118, 198, 122),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.black,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(text: 'Pantry Items'),
                Tab(text: 'Vegetables'),
                Tab(text: 'Dairy Items'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPantryGrid(), // Real pantry items
                _buildVegetablesGrid(), // Placeholder for vegetables
                _buildDairyGrid(), // Placeholder for dairy items
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new item functionality
        },
        backgroundColor: Colors.green[800],
        child: Icon(Icons.add),
      ),
    );
  }
}
