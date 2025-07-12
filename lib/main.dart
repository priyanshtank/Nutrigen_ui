import 'package:flutter/material.dart';
import 'pages/splashscreen.dart';

void main() {
  runApp(NutrigenApp());
}

class NutrigenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutrigen',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
