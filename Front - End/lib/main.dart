import 'package:flutter/material.dart';
import './Pages/IntroPage/Firstpage.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: IntroPage(), // Set IntroPage as the home
      debugShowCheckedModeBanner: false, // Remove the debug banner
    );
  }
}