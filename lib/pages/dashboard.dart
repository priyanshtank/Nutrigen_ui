import 'package:flutter/material.dart';
import 'scanner.dart'; // ✅ Import scanner page
import 'onboarding.dart'; // ⬅️ Add this import


class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              const Text(
                "Hi There 👋",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),

              // Daily Health Tip
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Daily Health Tip",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Did you know? High-fiber snacks support digestion.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // 🖼️ Image below grid
              Center(
                child: Image.asset(
                  'assets/Hamburger-bro.png',
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 40),

              // Grid Buttons
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 35,
                  children: [
                    // ✅ Scan Food
                    DashboardBox(
                      color: Colors.green.shade400,
                      
                      icon: Icons.qr_code_scanner,
                      label: 'Scan Food',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BarcodeScannerPage(),
                          ),
                        );
                      },
                    ),

                    // My Account (Placeholder)
                    DashboardBox(
                      color: Colors.green.shade200,
                      icon: Icons.person,
                      label: 'My Account',
                      onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OnboardingScreen(),
                        ),
                      );
                    },  
                    ),

                    // My Food Log (Placeholder)
                    DashboardBox(
                      color: Colors.green.shade100,
                      icon: Icons.calendar_today,
                      label: 'My Food Log',
                    ),

                    // Ask AI (Placeholder)
                    DashboardBox(
                      color: Colors.green.shade500,
                      icon: Icons.chat_bubble_outline,
                      label: 'Ask AI',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Updated DashboardBox to support onTap
class DashboardBox extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const DashboardBox({
    required this.color,
    required this.icon,
    required this.label,
    this.onTap, // Optional tap handler
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // ⬅️ Now clickable
      borderRadius: BorderRadius.circular(40),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(40),
        ),
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.black, size: 42),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
