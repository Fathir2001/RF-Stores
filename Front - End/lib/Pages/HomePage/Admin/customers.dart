import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shimmer/shimmer.dart';

class CustomersPage extends StatefulWidget {
  @override
  _CustomersPageState createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  List<Map<String, dynamic>> customers = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchCustomers();
  }

  Future<void> fetchCustomers() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:5000/api/customers/confirmed-orders'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            customers = List<Map<String, dynamic>>.from(data['data']);
            isLoading = false;
          });
        }
      } else {
        setState(() {
          error = 'Failed to load customers';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error: $e';
        isLoading = false;
      });
    }
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
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'CUSTOMERS',
              style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
              ),
            ),
          ),
          Shimmer.fromColors(
          baseColor: const Color.fromARGB(255, 41, 133, 44),
          highlightColor: const Color.fromARGB(255, 146, 243, 196),
          period: Duration(seconds: 2),
          child: Container(
            height: 2,
            width: 100,
            color: Colors.green,
            margin: EdgeInsets.only(top: 4),
          ),
        ),
        ],
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text(error!))
              : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: customers.length,
                  itemBuilder: (context, index) {
                    final customer = customers[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green[800],
                          child: Text(
                            customer['name'][0],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(customer['name']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Address: ${customer['address']}'),
                            Text('Phone: ${customer['phone']}'),
                          ],
                        ),
                        onTap: () {
                          // Handle customer selection
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
