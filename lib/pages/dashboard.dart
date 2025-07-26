import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nutrigen_ui/pages/chat_screen.dart';
import 'dart:convert';

import 'scanner.dart';
import 'get_started.dart';
import 'profile_page.dart';
import 'services/auth_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map<String, dynamic>? userData;
  bool isLoading = true;
  bool isError = false;
  String errorMessage = "";
  final String userId = "user001";

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    final String url =
        'https://neha-nutrigen-backend-db-546561582790.asia-south1.run.app/api/userprofile/?user_id=$userId';

    final token = await AuthService.getToken();

    if (token == null) {
      setState(() {
        isError = true;
        errorMessage = "Error: Unable to retrieve token.";
        isLoading = false;
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        setState(() {
          userData = decoded;
          isLoading = false;
        });
      } else {
        setState(() {
          isError = true;
          errorMessage = "Failed: ${response.statusCode}";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isError = true;
        errorMessage = "Exception: $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userName = userData?['name'] ?? 'There';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Column(
            children: [
              const SizedBox(height: 8),

              // 👤 Top-left profile icon
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.person,
                        color: Color(0xFF4CAF50), size: 28),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const PersonalInfoPage()),
                      );
                    },
                  ),
                ],
              ),

              // 👋 Greeting Header
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "Hey $userName!",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4CAF50),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Find, Track and eat Healthy",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4CB050),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 🍃 Healthy Diet Image Box
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
                child: Row(
                  children: [
                    Expanded(child: Container()), // spacing
                    Image.asset(
                      'assets/healthy-diet.png',
                      height: 250,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 📷 Scan/Search Card
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/scan.png',
                      height: 180,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Scan/Search Products",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Scan or search foods to get nutrition\n& protein information",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),

      // 🔻 Bottom Navigation Bar
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 76, 175, 80),
        shape: const CircularNotchedRectangle(),
        elevation: 8,
        notchMargin: 6,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // ✅ Home icon highlighted
              Container(
                height: 54,
                width: 54,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.home,
                      size: 28, color: Color.fromARGB(255, 76, 176, 80)),
                  onPressed: () {},
                ),
              ),

              // 🍴 Menu Icon
              IconButton(
                color: const Color.fromARGB(255, 246, 246, 246),
                icon: const Icon(Icons.restaurant_menu_outlined, size: 26),
                onPressed: () {},
              ),

              // 🔍 Scan Icon
              IconButton(
                icon: const Icon(Icons.qr_code_scanner, size: 30),
                color: const Color.fromARGB(255, 246, 246, 246),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BarcodeScannerPage(),
                    ),
                  );
                },
              ),

              // 💬 Chat Icon
              IconButton(
                color: const Color.fromARGB(255, 246, 246, 246),
                icon: const Icon(Icons.chat_bubble_outline, size: 26),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(),
                    ),
                  );
                },
              ),

              // 👤 Profile Icon (Get Started Page)
              IconButton(
                color: const Color.fromARGB(255, 246, 246, 246),
                icon: const Icon(Icons.person_outline, size: 28),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GetStartedPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
