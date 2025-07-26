import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'services/auth_service.dart';
import 'scanner.dart';
import 'dashboard.dart';
// import 'profile_page.dart';
import 'chat_screen.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  Map<String, dynamic>? userData;
  bool isLoading = true;
  bool isError = false;
  bool isEditing = false;
  String errorMessage = "";
  final String userId = "user001";

  final Color primaryGreen = const Color(0xFF4CAF50);

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  List<String> dietPreferences = [];
  List<String> allergies = [];

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
          _nameController.text = decoded['name'] ?? '';
          _ageController.text = decoded['age']?.toString() ?? '';
          _genderController.text = decoded['gender'] ?? '';
          dietPreferences =
              List<String>.from(decoded['diet_preferences'] ?? []);
          allergies = List<String>.from(decoded['allergies'] ?? []);
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

  Future<void> saveProfile() async {
    final updatedData = {
      "user_id": userId,
      "name": _nameController.text,
      "age": int.tryParse(_ageController.text),
      "gender": _genderController.text,
      "diet_preferences": dietPreferences,
      "allergies": allergies,
    };

    final String url =
        'https://neha-nutrigen-backend-db-546561582790.asia-south1.run.app/api/userprofile/';

    final token = await AuthService.getToken();

    if (token == null) {
      print("❌ Token retrieval failed.");
      return;
    }

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(updatedData),
      );

      if (response.statusCode == 200) {
        print("✅ Profile updated successfully!");
        print("🔄 Sent Data: $updatedData");

        // Refresh user data
        await fetchUserProfile();

        if (mounted) {
          setState(() {
            isEditing = false;
          });

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        print("❌ Failed to save data: ${response.statusCode}");
        print("❌ Response Body: ${response.body}");

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Error: ${response.statusCode} - ${response.reasonPhrase}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      print("❌ Exception while saving: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
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

  Widget buildChipEditor(List<String> items, Function(List<String>) onChanged) {
    final controller = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 6,
          children: items
              .map((item) => Chip(
                    label: Text(item),
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () {
                      onChanged(List.from(items)..remove(item));
                    },
                  ))
              .toList(),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Add item",
            suffixIcon: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  onChanged(List.from(items)..add(controller.text.trim()));
                  controller.clear();
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildChips(List<dynamic>? items) {
    if (items == null || items.isEmpty) {
      return const Text("None", style: TextStyle(color: Colors.grey));
    }
    return Wrap(
      spacing: 6,
      children: items
          .map((item) => Chip(
                label:
                    Text(item.toString(), style: const TextStyle(fontSize: 13)),
                backgroundColor: primaryGreen.withOpacity(0.1),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FA),
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: primaryGreen,
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              if (isEditing) {
                saveProfile();
              } else {
                setState(() {
                  isEditing = true;
                });
              }
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : isError
              ? Center(child: Text(errorMessage))
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
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
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                'https://i.pravatar.cc/150?img=12'),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: ListView(
                            children: [
                              buildField(
                                label: "Full Name",
                                icon: Icons.person_outline,
                                child: isEditing
                                    ? TextField(controller: _nameController)
                                    : Text(_nameController.text),
                              ),
                              buildField(
                                label: "Age",
                                icon: Icons.cake_outlined,
                                child: isEditing
                                    ? TextField(
                                        controller: _ageController,
                                        keyboardType: TextInputType.number,
                                      )
                                    : Text(_ageController.text),
                              ),
                              buildField(
                                label: "Gender",
                                icon: Icons.male_outlined,
                                child: isEditing
                                    ? TextField(controller: _genderController)
                                    : Text(_genderController.text),
                              ),
                              buildField(
                                label: "Diet Preferences",
                                icon: Icons.restaurant_menu_outlined,
                                child: isEditing
                                    ? buildChipEditor(
                                        dietPreferences,
                                        (val) => setState(() {
                                          dietPreferences = val;
                                        }),
                                      )
                                    : buildChips(dietPreferences),
                              ),
                              buildField(
                                label: "Allergies",
                                icon: Icons.medical_services_outlined,
                                child: isEditing
                                    ? buildChipEditor(
                                        allergies,
                                        (val) => setState(() {
                                          allergies = val;
                                        }),
                                      )
                                    : buildChips(allergies),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const DashboardScreen()),
                                  );
                                },
                                icon: const Icon(Icons.logout),
                                label: const Text("Log Out"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
              IconButton(
                icon: const Icon(Icons.home, size: 28, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DashboardScreen(),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.restaurant_menu_outlined, size: 26),
                color: Colors.white,
                onPressed: () {},
              ),
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
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline, size: 26),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.person_outline,
                    size: 28, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
