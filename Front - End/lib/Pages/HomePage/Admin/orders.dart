import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<dynamic>? _orders;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    try {
      print('Fetching orders...');
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final response = await http.get(
        Uri.parse('http://localhost:5000/api/customers/orders'),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success']) {
          setState(() {
            _orders = responseData['data'];
            _isLoading = false;
          });
          print('Orders loaded: ${_orders?.length}');
        } else {
          throw Exception('API returned success: false');
        }
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      print('Error fetching orders: $e');
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
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
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $_error'),
            ElevatedButton(
              onPressed: _fetchOrders,
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_orders == null || _orders!.isEmpty) {
      return Center(child: Text('No orders found'));
    }

    return RefreshIndicator(
      onRefresh: _fetchOrders,
      child: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: _orders?.length ?? 0,
        itemBuilder: (context, index) {
          final order = _orders![index];
          final String orderId =
              order['_id']?.toString().substring(0, 8) ?? 'N/A';
          final String customerName = order['name'] ?? 'Unknown';
          final dynamic totalAmount = order['totalAmount'] ?? 0.0;

          return Card(
            margin: EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              title: Text('Order #$orderId'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Customer: $customerName'),
                  Text('Total: \$${totalAmount.toString()}'),
                ],
              ),
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
              onTap: () => _showOrderDetails(order),
            ),
          );
        },
      ),
    );
  }

  void _showOrderDetails(dynamic order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Order Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Customer: ${order['name']}'),
              Text('Phone: ${order['phone']}'),
              Text('Address: ${order['address']}'),
              Divider(),
              Text('Items:', style: TextStyle(fontWeight: FontWeight.bold)),
              ...(order['orders'] as List).map((item) => Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '${item['itemName']} x${item['quantity']} - \$${item['price']}',
                    ),
                  )),
              Divider(),
              Text(
                'Total: \$${order['totalAmount']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
