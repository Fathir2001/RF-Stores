import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Color.fromARGB(255, 240, 250, 240),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.green[800],
                      ),
                      onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    FadeInDown(
                      duration: Duration(milliseconds: 500),
                      child: Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'assets/Images/Logo.png',
                        height: 120,
                      ),
                      ),
                    ),
                  SizedBox(height: 40),
                  FadeInDown(
                    delay: Duration(milliseconds: 200),
                    duration: Duration(milliseconds: 500),
                    child: Text(
                      'Admin Login',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 300),
                    duration: Duration(milliseconds: 500),
                    child: Text(
                      'Authorized Personnel Only',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        FadeInDown(
                          delay: Duration(milliseconds: 400),
                          duration: Duration(milliseconds: 500),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Admin Email',
                              prefixIcon:
                                  Icon(Icons.email, color: Colors.green),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.green),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        FadeInDown(
                          delay: Duration(milliseconds: 600),
                          duration: Duration(milliseconds: 500),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock, color: Colors.green),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.green),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        // FadeInDown(
                        //   delay: Duration(milliseconds: 800),
                        //   duration: Duration(milliseconds: 500),
                        //   child: Align(
                        //     alignment: Alignment.centerRight,
                        //     child: TextButton(
                        //       onPressed: () {
                        //         // Add forgot password functionality
                        //       },
                        //       child: Text(
                        //         'Forgot Password?',
                        //         style: TextStyle(color: Colors.green[800]),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(height: 20),
                        FadeInDown(
                          delay: Duration(milliseconds: 1000),
                          duration: Duration(milliseconds: 500),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Add login functionality
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[800],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: Size(double.infinity, 50),
                            ),
                            child: Text(
                              'Admin Login',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Add warning message here
                  FadeInUp(
                    duration: Duration(milliseconds: 500),
                    child: Text(
                      'This is a restricted area. Only authorized administrators can access.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red[700],
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Spacer(),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
