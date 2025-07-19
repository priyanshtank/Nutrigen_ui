import 'package:flutter/material.dart';
import 'scanner.dart';
import 'get_started.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Column(
            children: [
              const SizedBox(height: 8),

// 👋 Greeting Header
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SizedBox(height: 20),
                    Text(
                      "Hey There !",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4CAF50),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
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

              const SizedBox(height: 10),

              // 🍃 Healthy Diet Box
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text Column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                    const SizedBox(width: 0),
                    Image.asset(
                      'assets/healthy-diet.png',
                      height: 250,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

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

              // Menu Icon
              IconButton(
                color: const Color.fromARGB(255, 246, 246, 246),
                icon: const Icon(Icons.restaurant_menu_outlined, size: 26),
                onPressed: () {},
              ),

              // Scan Icon (normal now)
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

              // Chat Icon
              IconButton(
                color: const Color.fromARGB(255, 246, 246, 246),
                icon: const Icon(Icons.chat_bubble_outline, size: 26),
                onPressed: () {},
              ),

              // Profile Icon
              IconButton(
                color: const Color.fromARGB(255, 246, 246, 246),
                icon: const Icon(Icons.person_outline, size: 28),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const GetStartedPage(),
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
