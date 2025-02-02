import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shimmer/shimmer.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<dynamic>? _pendingOrders;
  List<dynamic>? _confirmedOrders;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchOrders();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchOrders() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final pendingResponse = await http.get(
        Uri.parse('http://localhost:5000/api/customers/orders'),
        headers: {'Content-Type': 'application/json'},
      );

      final confirmedResponse = await http.get(
        Uri.parse('http://localhost:5000/api/customers/confirmed-orders'),
        headers: {'Content-Type': 'application/json'},
      );

      if (pendingResponse.statusCode == 200 &&
          confirmedResponse.statusCode == 200) {
        final pendingData = json.decode(pendingResponse.body);
        final confirmedData = json.decode(confirmedResponse.body);

        setState(() {
          _pendingOrders = pendingData['data'];
          _confirmedOrders = confirmedData['data'];
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _markOrderAsComplete(String orderId) async {
    try {
      final response = await http.put(
        Uri.parse(
            'http://localhost:5000/api/customers/orders/$orderId/confirm'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        await _fetchOrders();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Order marked as complete')),
        );
      } else {
        throw Exception('Failed to update order');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
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

    final orders = isPending ? _pendingOrders : _confirmedOrders;

    if (orders == null || orders.isEmpty) {
      return Center(
        child: Text(isPending ? 'No pending orders' : 'No completed orders'),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchOrders,
      child: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            child: ListTile(
              title: Text('Order #${order['_id'].toString().substring(0, 8)}'),
              subtitle: Text('${order['name']} - \$${order['totalAmount']}'),
              trailing: isPending
                  ? ElevatedButton(
                      onPressed: () => _markOrderAsComplete(order['_id']),
                      child: Text('Mark Complete'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                      ),
                    )
                  : Icon(Icons.check_circle, color: Colors.green),
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
                    padding: EdgeInsets.only(left: 8.0),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Shimmer.fromColors(
          baseColor: const Color.fromARGB(255, 41, 133, 44),
          highlightColor: const Color.fromARGB(255, 146, 243, 196),
          period: Duration(seconds: 2),
          child: Text(
            'ORDERS',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
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
}
