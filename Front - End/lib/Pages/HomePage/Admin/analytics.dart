import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AnalyticsPage extends StatefulWidget {
  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  Future<double> fetchTotalSales() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:5000/api/customers/total-sales'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data']['totalSales'].toDouble();
      } else {
        throw Exception('Failed to load total sales');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          FadeInDown(
            duration: Duration(milliseconds: 500),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.green[800]),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Shimmer.fromColors(
                      baseColor: const Color.fromARGB(255, 41, 133, 44),
                      highlightColor: const Color.fromARGB(255, 146, 243, 196),
                      period: Duration(seconds: 2),
                      child: Column(
                        children: [
                          Text(
                            'ANALYTICS',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              letterSpacing: 2,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: Divider(
                              height: 2,
                              thickness: 4,
                              indent: 50,
                              endIndent: 50,
                              color: Colors.green[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 48),
                ],
              ),
            ),
          ),
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInLeft(
                    duration: Duration(milliseconds: 500),
                    child: Text(
                      'Business Overview',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // Analytics Cards
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: [
                      FutureBuilder<double>(
                        future: fetchTotalSales(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return _buildAnalyticCard(
                              'Total Sales',
                              'Loading...',
                              Icons.attach_money,
                              Colors.green,
                            );
                          } else if (snapshot.hasError) {
                            return _buildAnalyticCard(
                              'Total Sales',
                              'Error',
                              Icons.attach_money,
                              Colors.green,
                            );
                          }
                          return _buildAnalyticCard(
                            'Total Sales',
                            '₱${snapshot.data?.toStringAsFixed(2) ?? '0.00'}',
                            Icons.attach_money,
                            Colors.green,
                          );
                        },
                      ),
                      _buildAnalyticCard(
                        'Orders',
                        '125',
                        Icons.shopping_cart,
                        Colors.blue,
                      ),
                      _buildAnalyticCard(
                        'Customers',
                        '48',
                        Icons.people,
                        Colors.orange,
                      ),
                      _buildAnalyticCard(
                        'Products',
                        '96',
                        Icons.inventory,
                        Colors.purple,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticCard(String title, String value, IconData icon, MaterialColor color) {
    return FadeInUp(
      duration: Duration(milliseconds: 500),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color.shade300, color.shade700],
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 32,
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}