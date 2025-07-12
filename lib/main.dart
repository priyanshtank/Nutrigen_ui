import 'package:flutter/material.dart';
import 'pages/scanner.dart';

void main() => runApp(const BarcodeScannerApp()); // Entry point of the application

class BarcodeScannerApp extends StatelessWidget { // Main application widget
  const BarcodeScannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // MaterialApp is the root of the application
      title: 'Barcode Scanner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green), //Applies a green theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const BarcodeScannerPage(), // Sets the home page of the app to BarcodeScannerPage
    );
  }
}
