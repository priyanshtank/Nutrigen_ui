// import 'package:flutter/material.dart';
// import 'pages/splashscreen.dart';

// void main() {
//   runApp(NutrigenApp());
// }

// class NutrigenApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Nutrigen',
//       debugShowCheckedModeBanner: false,
//       home: SplashScreen(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const NutrigenApp());
}

class NutrigenApp extends StatelessWidget {
  const NutrigenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutrigen',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
