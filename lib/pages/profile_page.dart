import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'services/auth_service.dart';
import 'scanner.dart';
import 'dashboard.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  Map<String, dynamic>? userData;
  bool isLoading = true;
  bool isError = false;
  String errorMessage = "";
  final String userId = "user001";

  final Color primaryGreen = const Color(0xFF4CAF50);

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

  Widget buildField({
    required String label,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: primaryGreen.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black87)),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(icon, color: primaryGreen, size: 22),
              const SizedBox(width: 12),
              Expanded(child: child),
            ],
          )
        ],
      ),
    );
  }

  Widget buildChips(List<dynamic>? items) {
    if (items == null || items.isEmpty) {
      return const Text("None", style: TextStyle(color: Colors.grey));
    }
    return Wrap(
      spacing: 6,
      runSpacing: -8,
      children: items
          .map((item) => Chip(
                label:
                    Text(item.toString(), style: const TextStyle(fontSize: 13)),
                backgroundColor: primaryGreen.withOpacity(0.1),
                labelStyle: const TextStyle(color: Colors.black87),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FA),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : isError
              ? Center(child: Text(errorMessage))
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "Your Profile",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: primaryGreen,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Avatar with shadow
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: primaryGreen.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                'https://i.pravatar.cc/150?img=12'),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Info Fields
                        Expanded(
                          child: ListView(
                            children: [
                              buildField(
                                label: "Full Name",
                                icon: Icons.person_outline,
                                child: Text(userData?['name'] ?? 'N/A',
                                    style: const TextStyle(fontSize: 15)),
                              ),
                              buildField(
                                label: "Age",
                                icon: Icons.cake_outlined,
                                child: Text(
                                    userData?['age']?.toString() ?? 'N/A',
                                    style: const TextStyle(fontSize: 15)),
                              ),
                              buildField(
                                label: "Gender",
                                icon: Icons.male_outlined,
                                child: Text(userData?['gender'] ?? 'N/A',
                                    style: const TextStyle(fontSize: 15)),
                              ),
                              buildField(
                                label: "Diet Preferences",
                                icon: Icons.restaurant_menu_outlined,
                                child:
                                    buildChips(userData?['diet_preferences']),
                              ),
                              buildField(
                                label: "Allergies",
                                icon: Icons.medical_services_outlined,
                                child: buildChips(userData?['allergies']),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

      // ✅ Bottom Navigation Bar (copied from Dashboard)
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
              // Home icon
              IconButton(
                icon: const Icon(Icons.home,
                    size: 28, color: Color.fromARGB(255, 255, 255, 255)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DashboardScreen(),
                    ),
                  );
                },
              ),
              // Menu
              IconButton(
                icon: const Icon(Icons.restaurant_menu_outlined, size: 26),
                color: Colors.white,
                onPressed: () {},
              ),
              // QR Code Scanner
              IconButton(
                icon: const Icon(Icons.qr_code_scanner, size: 30),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BarcodeScannerPage(),
                    ),
                  );
                },
              ),
              // Chat
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline, size: 26),
                color: Colors.white,
                onPressed: () {},
              ),
              // Active Profile Icon
              Container(
                height: 54,
                width: 54,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.person_outline,
                      size: 28, color: Color.fromARGB(255, 76, 175, 80)),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
