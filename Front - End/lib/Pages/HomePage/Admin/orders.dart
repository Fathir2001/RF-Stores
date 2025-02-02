import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders Management'),
        backgroundColor: Colors.green[800],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          tabs: [
            Tab(text: 'Pending Orders'),
            Tab(text: 'Completed Orders'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrdersList(isPending: true),
          _buildOrdersList(isPending: false),
        ],
      ),
    );
  }

  Widget _buildOrdersList({required bool isPending}) {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: 0, // Replace with actual orders count
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            title: Text('Order #12345'),
            subtitle: Text('Customer Name - \$XX.XX'),
            trailing: isPending
                ? ElevatedButton(
                    onPressed: () {
                      // Handle mark as complete
                    },
                    child: Text('Mark Complete'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                    ),
                  )
                : Icon(Icons.check_circle, color: Colors.green[800]),
            onTap: () {
              // Show order details
            },
          ),
        );
      },
    );
  }
}