import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:animate_do/animate_do.dart';
import 'manageInventory.dart';
import 'orders.dart';
import '../MainHomepage.dart';
import 'customers.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  Future<void> _showLogoutDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Logout Confirmation',
            style: TextStyle(
              color: Colors.green[800],
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              child: Text(
                'No',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text(
                'Yes',
                style: TextStyle(
                  color: Colors.green[800],
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('token');
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainHomePage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'assets/Images/Logo.png',
                        height: 60,
                        width: 80,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Shimmer.fromColors(
                      baseColor: const Color.fromARGB(255, 41, 133, 44),
                      highlightColor: const Color.fromARGB(255, 146, 243, 196),
                      period: Duration(seconds: 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ADMIN',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
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
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: IconButton(
                      icon: Icon(
                        Icons.logout,
                        color: Colors.green[800],
                        size: 30,
                      ),
                      onPressed: _showLogoutDialog,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInLeft(
                    duration: Duration(milliseconds: 500),
                    child: Text(
                      'Management Options',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.3,
                    children: [
                      FadeInUp(
                        duration: Duration(milliseconds: 600),
                        child: _buildEnhancedMenuItem(
                          icon: Icons.inventory,
                          title: 'Inventory',
                          color: Colors.green,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ManageInventoryPage()),
                          ),
                        ),
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 700),
                        child: _buildEnhancedMenuItem(
                          icon: Icons.shopping_cart,
                          title: 'Orders',
                          color: Colors.blue,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrdersPage()),
                          ),
                        ),
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 800),
                        child: _buildEnhancedMenuItem(
                          icon: Icons.people,
                          title: 'Customers',
                          color: Colors.orange,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomersPage()),
                          ),
                        ),
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 900),
                        child: _buildEnhancedMenuItem(
                          icon: Icons.analytics,
                          title: 'Analytics',
                          color: Colors.purple,
                          onTap: () {
                            // Navigate to analytics
                          },
                        ),
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

  Widget _buildEnhancedMenuItem({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    MaterialColor getMaterialColor(Color color) {
      if (color == Colors.green) return Colors.green;
      if (color == Colors.blue) return Colors.blue;
      if (color == Colors.orange) return Colors.orange;
      if (color == Colors.purple) return Colors.purple;
      return Colors.blue; // default fallback
    }

    MaterialColor materialColor = getMaterialColor(color);

    return Material(
    elevation: 6, // Reduced from 8
    shadowColor: color.withOpacity(0.3),
    borderRadius: BorderRadius.circular(15), // Reduced from 20
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15), // Reduced from 20
      child: Container(
        padding: EdgeInsets.all(10), // Reduced from 15
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              materialColor.shade300,
              materialColor.shade700,
            ],
          ),
          borderRadius: BorderRadius.circular(15), // Reduced from 20
          border: Border.all(
            color: Colors.white.withOpacity(0.25),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8), // Reduced from 12
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12), // Reduced from 15
              ),
              child: Icon(
                icon,
                size: 32, // Reduced from 40
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8), // Reduced from 12
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14, // Reduced from 16
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
}

