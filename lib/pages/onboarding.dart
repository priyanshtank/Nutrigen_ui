import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dashboard.dart';
import 'services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentStep = 0;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _customDietController = TextEditingController();
  final TextEditingController _customAllergyController =
      TextEditingController();

  String? _gender;
  List<String> _dietPrefs = [];
  List<String> _allergies = [];

  final List<Map<String, dynamic>> dietOptions = [
    {'label': 'Vegan', 'icon': Icons.eco},
    {'label': 'Vegetarian', 'icon': Icons.grass},
    {'label': 'Jain', 'icon': Icons.spa},
    {'label': 'Eggitarian', 'icon': Icons.egg_alt},
    {'label': 'Keto', 'icon': Icons.local_fire_department},
    {'label': 'Diabetic-Friendly', 'icon': Icons.monitor_heart},
    {'label': 'Gluten-Free', 'icon': Icons.no_food},
    {'label': 'Organic', 'icon': Icons.eco_outlined},
    {'label': 'Halal', 'icon': Icons.verified_user},
  ];

  final List<Map<String, dynamic>> allergyOptions = [
    {'label': 'Dairy', 'icon': Icons.icecream},
    {'label': 'Gluten', 'icon': Icons.no_food},
    {'label': 'Peanuts', 'icon': Icons.rice_bowl},
    {'label': 'Shellfish', 'icon': Icons.set_meal},
    {'label': 'Eggs', 'icon': Icons.egg},
    {'label': 'Soy', 'icon': Icons.grain},
    {'label': 'Tree nuts', 'icon': Icons.park},
    {'label': 'Garlic', 'icon': Icons.local_florist},
  ];

  // void _submitData() async {
  //   final payload = {
  //     "user_id": "user997",
  //     "name": _nameController.text.trim(),
  //     "age": int.tryParse(_ageController.text.trim()) ?? 0,
  //     "gender": _gender,
  //     "diet_preferences": _dietPrefs,
  //     "allergies": _allergies.contains("None") ? [] : _allergies
  //   };

  //   final apiUrl = "https://b91thk34-8000.inc1.devtunnels.ms/submit-user/";

  //   try {
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Authorization": "Bearer YOUR_TOKEN", // Uncomment if needed
  //       },
  //       body: jsonEncode(payload),
  //     );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       print("✅ Submission successful!");
  //       print("📦 Server Response: ${response.body}");

  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("Profile submitted successfully!")),
  //       );

  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => DashboardScreen()),
  //       );
  //     } else {
  //       print("❌ Submission failed: ${response.statusCode}");
  //       print("🪵 Server Error: ${response.body}");

  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Failed: ${response.statusCode}")),
  //       );
  //     }
  //   } catch (e) {
  //     print("🔥 Exception occurred: $e");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //           content: Text("Something went wrong. Please try again.")),
  //     );
  //   }
  // }

  void _submitData() async {
    final token = await AuthService.getToken(); // ✅ Get token
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error: Could not get auth token")),
      );
      return;
    }

    final payload = {
      "user_id": FirebaseAuth.instance.currentUser?.uid ??
          "unknown_user", // ✅ Use UID if available
      "name": _nameController.text.trim(),
      "age": int.tryParse(_ageController.text.trim()) ?? 0,
      "gender": _gender,
      "diet_preferences": _dietPrefs,
      "allergies": _allergies.contains("None") ? [] : _allergies
    };

    final apiUrl = "https://b91thk34-8000.inc1.devtunnels.ms/submit-user/";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // ✅ Injected token
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("✅ Submission successful!");
        print("📦 Server Response: ${response.body}");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile submitted successfully!")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      } else {
        print("❌ Submission failed: ${response.statusCode}");
        print("🪵 Server Error: ${response.body}");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed: ${response.statusCode}")),
        );
      }
    } catch (e) {
      print("🔥 Exception occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Something went wrong. Please try again.")),
      );
    }
  }

  Widget buildStepIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Step ${_currentStep + 1} of 3",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: LinearProgressIndicator(
            value: (_currentStep + 1) / 3,
            backgroundColor: Colors.grey.shade300,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            minHeight: 6,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget buildDietChips() {
    return Center(
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: [
          ..._dietPrefs.map((diet) => GestureDetector(
                onTap: () => setState(() => _dietPrefs.remove(diet)),
                child: Container(
                  height: 90,
                  width: 160,
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(diet,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
              )),
          ...dietOptions
              .where((d) => !_dietPrefs.contains(d['label']))
              .map((diet) => GestureDetector(
                    onTap: () => setState(() => _dietPrefs.add(diet['label'])),
                    child: Container(
                      height: 90,
                      width: 160,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(diet['icon'], color: Colors.green, size: 28),
                          const SizedBox(height: 6),
                          Text(diet['label'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                  ))
        ],
      ),
    );
  }

  Widget buildAllergyChips() {
    return Center(
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: [
          ..._allergies.map((a) => GestureDetector(
                onTap: () {
                  if (_allergies.contains("None")) return;
                  setState(() => _allergies.remove(a));
                },
                child: Container(
                  height: 90,
                  width: 160,
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        allergyOptions.firstWhere(
                          (opt) => opt['label'] == a,
                          orElse: () => {'icon': Icons.info},
                        )['icon'],
                        color: Colors.red,
                      ),
                      const SizedBox(height: 6),
                      Text(a,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              )),
          ...allergyOptions
              .where((a) => !_allergies.contains(a['label']))
              .map((a) => GestureDetector(
                    onTap: () {
                      if (_allergies.contains("None")) return;
                      setState(() => _allergies.add(a['label']));
                    },
                    child: Container(
                      height: 90,
                      width: 160,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(a['icon'], color: Colors.red),
                          const SizedBox(height: 6),
                          Text(a['label'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildStepIndicator(),
                if (_currentStep == 0) ...[
                  const SizedBox(height: 16),
                  const Text("Let's personalize your experience!",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 48,
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: "Your Name",
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 48,
                    child: TextField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Your Age",
                        prefixIcon: Icon(Icons.calendar_today_outlined),
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    children: ["Male", "Female", "Other"]
                        .map((g) => ChoiceChip(
                              label: Text(g),
                              selected: _gender == g,
                              selectedColor: Colors.green,
                              onSelected: (_) => setState(() => _gender = g),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 14)),
                      onPressed: () => setState(() => _currentStep = 1),
                      child: const Text("Continue",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  )
                ] else if (_currentStep == 1) ...[
                  const Text("Your Diet Preferences",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  const Text("Select all that apply",
                      style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 20),
                  buildDietChips(),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _customDietController,
                          decoration: const InputDecoration(
                              hintText: 'Add custom diet'),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          final value = _customDietController.text.trim();
                          if (value.isNotEmpty && !_dietPrefs.contains(value)) {
                            setState(() {
                              _dietPrefs.add(value);
                              _customDietController.clear();
                            });
                          }
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 14)),
                      onPressed: () => setState(() => _currentStep = 2),
                      child: const Text("Continue",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                  TextButton(
                    onPressed: () => setState(() => _currentStep = 2),
                    child: const Text("Skip",
                        style: TextStyle(color: Colors.green)),
                  )
                ] else if (_currentStep == 2) ...[
                  const Text("Any food allergies?",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  const Text("Select all that apply to you",
                      style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 20),
                  buildAllergyChips(),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _customAllergyController,
                          decoration: const InputDecoration(
                              hintText: 'Add custom allergy'),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          final value = _customAllergyController.text.trim();
                          if (value.isNotEmpty && !_allergies.contains(value)) {
                            setState(() {
                              _allergies.add(value);
                              _customAllergyController.clear();
                            });
                          }
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      setState(() => _allergies = ["None"]);
                    },
                    child: const Text("None",
                        style: TextStyle(color: Colors.green)),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 14)),
                      onPressed: _submitData,
                      child: const Text("Complete Set up",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
