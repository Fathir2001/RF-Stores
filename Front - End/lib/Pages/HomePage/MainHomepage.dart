import 'package:flutter/material.dart';
import './Category/Category.dart';
import 'package:carousel_slider/carousel_slider.dart';
import './Products/dairy.dart';
import './Products/pantry.dart';
import './Products/vegetables.dart';
import 'package:shimmer/shimmer.dart';
import 'package:animate_do/animate_do.dart';
import './Login/login.dart';

class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static final List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    CategoryPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Changed to spaceBetween
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
                            'R.F STORES',
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
                        Icons.person,
                        color: Colors.green[800],
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          
          SizedBox(height: 10),
          Expanded(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),
      bottomNavigationBar: FadeInUp(
        duration: Duration(milliseconds: 500),
        child: Container(
          height: 60, // Decreased height
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Color.fromARGB(255, 240, 250, 240)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 15,
                offset: Offset(0, -3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _selectedIndex == 0
                          ? Colors.green.withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.home, size: 18),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _selectedIndex == 1
                          ? Colors.green.withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.category, size: 18),
                  ),
                  label: 'Category',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.green[800],
              unselectedItemColor: Colors.grey[600],
              selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 10,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 12,
              unselectedFontSize: 10,
              iconSize: 18,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final List<String> bannerImages = [
    'assets/Images/HomePage/week.jpg',
    'assets/Images/HomePage/delivery.jpg',
    'assets/Images/HomePage/rf.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInDown(
            duration: Duration(milliseconds: 800),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 180.0,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.easeInOut,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              items: bannerImages.map((imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),

          // Categories Section
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInLeft(
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeInLeft(
                        duration: Duration(milliseconds: 600),
                        child: _buildEnhancedCategoryCard(
                            context, 'Pantry', Icons.kitchen, PantryPage()),
                      ),
                      FadeInLeft(
                        duration: Duration(milliseconds: 700),
                        child: _buildEnhancedCategoryCard(
                            context, 'Vegetables', Icons.eco, VegetablesPage()),
                      ),
                      FadeInLeft(
                        duration: Duration(milliseconds: 800),
                        child: _buildEnhancedCategoryCard(
                            context, 'Dairy', Icons.egg, DairyPage()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Special Offers
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInLeft(
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    'Special Offers',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.8,
                  children: [
                    FadeInUp(
                      duration: Duration(milliseconds: 600),
                      child: _buildEnhancedProductCard(
                          'Fresh Apples',
                          '2.99',
                          '3.99',
                          '25% OFF',
                          'assets/Images/HomePage/apples.jpg'),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 700),
                      child: _buildEnhancedProductCard(
                          'Bananas',
                          '1.99',
                          '2.49',
                          '20% OFF',
                          'assets/Images/HomePage/bananas.jpg'),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 800),
                      child: _buildEnhancedProductCard(
                          'Orange Pack',
                          '4.99',
                          '5.99',
                          '15% OFF',
                          'assets/Images/HomePage/oranges.jpg'),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 900),
                      child: _buildEnhancedProductCard(
                          'Mixed Berries',
                          '6.99',
                          '8.99',
                          '30% OFF',
                          'assets/Images/HomePage/berries.webp'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

    Widget _buildEnhancedCategoryCard(
      BuildContext context, String title, IconData icon, Widget page) {
    return Container(
      width: 120, // Decreased from 140
      margin: EdgeInsets.only(right: 15), // Decreased from 20
      child: Material(
        elevation: 8, // Decreased from 10
        shadowColor: Colors.green.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            padding: EdgeInsets.all(12), // Decreased from 15
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: title == 'Pantry'
                    ? [Color(0xFF66BB6A), Color(0xFF1B5E20)]
                    : title == 'Vegetables'
                        ? [Color(0xFF26A69A), Color(0xFF004D40)]
                        : [Color(0xFF42A5F5), Color(0xFF0D47A1)],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.25),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10), // Decreased from 15
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    icon,
                    size: 35, // Decreased from 45
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8), // Decreased from 15
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15, // Decreased from 17
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5), // Decreased from 8
                Container(
                  width: 30, // Decreased from 40
                  height: 2, // Decreased from 3
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildEnhancedProductCard(String name, String price, String oldPrice,
      String discount, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 0,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Text(
                        discount,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          '\$$price',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '\$$oldPrice',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            fontSize: 14,
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
      ),
    );
  }
}
