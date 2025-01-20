import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../HomePage/MainHomepage.dart';
import 'package:simple_animations/simple_animations.dart';
import 'dart:math' as math;

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _buttonController;
  late Animation<double> _logoAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _logoAnimation = Tween<double>(begin: -100, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _buttonController,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _buttonController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF81C784),
                    Color(0xFFA5D6A7),
                    Color(0xFFFFF59D),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: CustomPaint(
                painter: BackgroundPainter(),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),

                  // Logo animation
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _logoAnimation.value),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 20,
                                spreadRadius: 5,
                              )
                            ],
                          ),
                          child: Image.asset(
                            'assets/Images/Logo.png',
                            width: MediaQuery.of(context).size.width * 0.6,
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                  ),

                  // Welcome text section
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShimmerText('WELCOME'),
                        SizedBox(height: 24),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Fresh, Fast, and Affordable!',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: const Color.fromARGB(255, 45, 143, 86),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        // IntroPage image
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Image.asset(
                                'assets/Images/IntroPage.png',
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Get Started Button
                  Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        MainHomePage(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                                transitionDuration: Duration(milliseconds: 800),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 8,
                          ),
                          child: Text(
                            'Get Started',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF43A047),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerText extends StatelessWidget {
  final String text;
  ShimmerText(this.text);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 0,0,0),
      highlightColor: Colors.white.withOpacity(0.5),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          letterSpacing: 4.0,
        ),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..isAntiAlias = true;

    paint.color = Color(0xFF43A047).withOpacity(0.15);
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.2), 100, paint);

    paint.color = Color(0xFFFFEB3B).withOpacity(0.1);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.3), 150, paint);

    paint.color = Color(0xFF81C784).withOpacity(0.2);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.8), 200, paint);

    paint.color = Colors.white.withOpacity(0.05);
    for (int i = 0; i < 10; i++) {
      double dx = math.Random().nextDouble() * size.width;
      double dy = math.Random().nextDouble() * size.height;
      canvas.drawCircle(Offset(dx, dy), 8, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 8, dashSpace = 4, startX = 0;
    final paint = Paint()
      ..color = const Color.fromARGB(255, 0, 0, 0)
      ..strokeWidth = 2;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
