// // // // lib/pages/onboarding.dart
// // // import 'package:flutter/material.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'dart:convert';

// // // class OnboardingScreen extends StatefulWidget {
// // //   const OnboardingScreen({super.key});

// // //   @override
// // //   State<OnboardingScreen> createState() => _OnboardingScreenState();
// // // }

// // // class _OnboardingScreenState extends State<OnboardingScreen> {
// // //   int _currentStep = 0;

// // //   final TextEditingController _nameController = TextEditingController();
// // //   final TextEditingController _ageController = TextEditingController();
// // //   final TextEditingController _customDietController = TextEditingController();
// // //   final TextEditingController _customAllergyController = TextEditingController();

// // //   String? _gender;
// // //   List<String> _dietPrefs = [];
// // //   List<String> _allergies = [];

// // //   final List<String> dietOptions = [
// // //     'Vegan', 'Vegetarian', 'Jain', 'Eggitarian', 'Keto',
// // //     'Diabetic-Friendly', 'Gluten-Free', 'Organic', 'Halal'
// // //   ];

// // //   final List<String> allergyOptions = [
// // //     'Dairy', 'Gluten', 'Peanuts', 'Shellfish',
// // //     'Eggs', 'Soy', 'Tree nuts', 'Garlic'
// // //   ];

// // //   void _submitData() async {
// // //     final payload = {
// // //       "name": _nameController.text.trim(),
// // //       "age": int.tryParse(_ageController.text.trim()) ?? 0,
// // //       "gender": _gender,
// // //       "diet_preferences": _dietPrefs,
// // //       "allergies": _allergies
// // //     };

// // //     final response = await http.post(
// // //       // Uri.parse("http://192.168.29.18:8000/onboarding"), // Replace with actual API
// // //       Uri.parse("http://localhost:8000/onboarding"),
// // //       headers: {"Content-Type": "application/json"},
// // //       body: jsonEncode(payload),
// // //     );

// // //     if (response.statusCode == 200) {
// // //       showDialog(
// // //         context: context,
// // //         builder: (_) => AlertDialog(
// // //           title: const Text("Success"),
// // //           content: const Text("Your preferences have been saved!"),
// // //           actions: [
// // //             TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))
// // //           ],
// // //         ),
// // //       );
// // //     } else {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(content: Text("Something went wrong!"))
// // //       );
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: const Text("Set Up Your Profile")),
// // //       body: Stepper(
// // //         type: StepperType.vertical,
// // //         currentStep: _currentStep,
// // //         onStepContinue: () {
// // //           if (_currentStep < 2) {
// // //             setState(() => _currentStep++);
// // //           } else {
// // //             _submitData();
// // //           }
// // //         },
// // //         onStepCancel: () {
// // //           if (_currentStep > 0) setState(() => _currentStep--);
// // //         },
// // //         controlsBuilder: (context, details) => Padding(
// // //           padding: const EdgeInsets.only(top: 20),
// // //           child: Row(
// // //             children: [
// // //               ElevatedButton(
// // //                 onPressed: details.onStepContinue,
// // //                 child: Text(_currentStep == 2 ? "Complete Set up" : "Continue"),
// // //               ),
// // //               const SizedBox(width: 10),
// // //               if (_currentStep > 0)
// // //                 TextButton(
// // //                   onPressed: details.onStepCancel,
// // //                   child: const Text("Back"),
// // //                 ),
// // //             ],
// // //           ),
// // //         ),
// // //         steps: [
// // //           Step(
// // //             title: const Text("Step 1 of 3"),
// // //             content: Column(
// // //               children: [
// // //                 TextField(controller: _nameController, decoration: const InputDecoration(labelText: "Your Name")),
// // //                 TextField(controller: _ageController, decoration: const InputDecoration(labelText: "Your Age"), keyboardType: TextInputType.number),
// // //                 Wrap(
// // //                   spacing: 10,
// // //                   children: ["Male", "Female", "Other"].map((g) => ChoiceChip(
// // //                     label: Text(g),
// // //                     selected: _gender == g,
// // //                     onSelected: (_) => setState(() => _gender = g),
// // //                   )).toList(),
// // //                 ),
// // //               ],
// // //             ),
// // //             isActive: _currentStep >= 0,
// // //           ),
// // //           Step(
// // //             title: const Text("Step 2 of 3"),
// // //             content: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 const Text("Your Diet Preferences"),
// // //                 const SizedBox(height: 10),
// // //                 Wrap(
// // //                   spacing: 8,
// // //                   runSpacing: 8,
// // //                   children: _dietPrefs.map((diet) => FilterChip(
// // //                     label: Text(diet),
// // //                     selected: true,
// // //                     onSelected: (_) => setState(() => _dietPrefs.remove(diet)),
// // //                   )).toList()
// // //                   + dietOptions.where((d) => !_dietPrefs.contains(d)).map((diet) => FilterChip(
// // //                     label: Text(diet),
// // //                     selected: false,
// // //                     onSelected: (val) => setState(() => _dietPrefs.add(diet)),
// // //                   )).toList(),
// // //                 ),
// // //                 const SizedBox(height: 10),
// // //                 Row(
// // //                   children: [
// // //                     Expanded(
// // //                       child: TextField(
// // //                         controller: _customDietController,
// // //                         decoration: const InputDecoration(hintText: 'Add custom diet'),
// // //                       ),
// // //                     ),
// // //                     IconButton(
// // //                       icon: const Icon(Icons.add),
// // //                       onPressed: () {
// // //                         final value = _customDietController.text.trim();
// // //                         if (value.isNotEmpty && !_dietPrefs.contains(value)) {
// // //                           setState(() {
// // //                             _dietPrefs.add(value);
// // //                             _customDietController.clear();
// // //                           });
// // //                         }
// // //                       },
// // //                     )
// // //                   ],
// // //                 ),
// // //               ],
// // //             ),
// // //             isActive: _currentStep >= 1,
// // //           ),
// // //           Step(
// // //             title: const Text("Step 3 of 3"),
// // //             content: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 const Text("Any food allergies?"),
// // //                 const SizedBox(height: 10),
// // //                 Wrap(
// // //                   spacing: 8,
// // //                   runSpacing: 8,
// // //                   children: _allergies.map((a) => FilterChip(
// // //                     label: Text(a),
// // //                     selected: true,
// // //                     onSelected: (_) => setState(() => _allergies.remove(a)),
// // //                   )).toList()
// // //                   + allergyOptions.where((a) => !_allergies.contains(a)).map((a) => FilterChip(
// // //                     label: Text(a),
// // //                     selected: false,
// // //                     onSelected: (val) => setState(() => _allergies.add(a)),
// // //                   )).toList(),
// // //                 ),
// // //                 const SizedBox(height: 10),
// // //                 Row(
// // //                   children: [
// // //                     Expanded(
// // //                       child: TextField(
// // //                         controller: _customAllergyController,
// // //                         decoration: const InputDecoration(hintText: 'Add custom allergy'),
// // //                       ),
// // //                     ),
// // //                     IconButton(
// // //                       icon: const Icon(Icons.add),
// // //                       onPressed: () {
// // //                         final value = _customAllergyController.text.trim();
// // //                         if (value.isNotEmpty && !_allergies.contains(value)) {
// // //                           setState(() {
// // //                             _allergies.add(value);
// // //                             _customAllergyController.clear();
// // //                           });
// // //                         }
// // //                       },
// // //                     )
// // //                   ],
// // //                 ),
// // //                 const SizedBox(height: 10),
// // //                 FilterChip(
// // //                   label: const Text("None"),
// // //                   selected: _allergies.isEmpty,
// // //                   onSelected: (_) => setState(() => _allergies.clear()),
// // //                 )
// // //               ],
// // //             ),
// // //             isActive: _currentStep >= 2,
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }




// // // lib/pages/onboarding.dart
// // // import 'package:flutter/material.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'dart:convert';

// // // class OnboardingScreen extends StatefulWidget {
// // //   const OnboardingScreen({super.key});

// // //   @override
// // //   State<OnboardingScreen> createState() => _OnboardingScreenState();
// // // }

// // // class _OnboardingScreenState extends State<OnboardingScreen> {
// // //   int _currentStep = 0;

// // //   final TextEditingController _nameController = TextEditingController();
// // //   final TextEditingController _ageController = TextEditingController();
// // //   final TextEditingController _customDietController = TextEditingController();
// // //   final TextEditingController _customAllergyController = TextEditingController();

// // //   String? _gender;
// // //   List<String> _dietPrefs = [];
// // //   List<String> _allergies = [];
// // //   bool _noneAllergySelected = false;

// // //   final List<Map<String, dynamic>> dietOptions = [
// // //     {'label': 'Vegan', 'icon': Icons.eco},
// // //     {'label': 'Vegetarian', 'icon': Icons.local_florist},
// // //     {'label': 'Jain', 'icon': Icons.spa},
// // //     {'label': 'Eggitarian', 'icon': Icons.egg},
// // //     {'label': 'Keto', 'icon': Icons.bolt},
// // //     {'label': 'Diabetic-Friendly', 'icon': Icons.monitor_heart},
// // //     {'label': 'Gluten-Free', 'icon': Icons.grass},
// // //     {'label': 'Organic', 'icon': Icons.nature},
// // //     {'label': 'Halal', 'icon': Icons.verified},
// // //   ];

// // //   final List<Map<String, dynamic>> allergyOptions = [
// // //     {'label': 'Dairy', 'icon': Icons.local_drink},
// // //     {'label': 'Gluten', 'icon': Icons.no_food},
// // //     {'label': 'Peanuts', 'icon': Icons.set_meal},
// // //     {'label': 'Shellfish', 'icon': Icons.lunch_dining},
// // //     {'label': 'Eggs', 'icon': Icons.egg},
// // //     {'label': 'Soy', 'icon': Icons.soup_kitchen},
// // //     {'label': 'Tree nuts', 'icon': Icons.park},
// // //     {'label': 'Garlic', 'icon': Icons.local_dining},
// // //   ];

// // //   void _submitData() async {
// // //     final payload = {
// // //       "name": _nameController.text.trim(),
// // //       "age": int.tryParse(_ageController.text.trim()) ?? 0,
// // //       "gender": _gender,
// // //       "diet_preferences": _dietPrefs,
// // //       "allergies": _allergies
// // //     };

// // //     final response = await http.post(
// // //       Uri.parse("http://localhost:8000/onboarding"),
// // //       headers: {"Content-Type": "application/json"},
// // //       body: jsonEncode(payload),
// // //     );

// // //     if (response.statusCode == 200) {
// // //       showDialog(
// // //         context: context,
// // //         builder: (_) => AlertDialog(
// // //           title: const Text("Success"),
// // //           content: const Text("Your preferences have been saved!"),
// // //           actions: [
// // //             TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))
// // //           ],
// // //         ),
// // //       );
// // //     } else {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(content: Text("Something went wrong!"))
// // //       );
// // //     }
// // //   }

// // //   Widget _stepIndicator() {
// // //     return LinearProgressIndicator(
// // //       value: (_currentStep + 1) / 3,
// // //       valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
// // //       backgroundColor: Colors.grey.shade300,
// // //       minHeight: 4,
// // //     );
// // //   }

// // //   Widget _greenButton(String label, VoidCallback onPressed) {
// // //     return SizedBox(
// // //       width: double.infinity,
// // //       child: ElevatedButton(
// // //         onPressed: onPressed,
// // //         style: ElevatedButton.styleFrom(
// // //           backgroundColor: Colors.green,
// // //           foregroundColor: Colors.white,
// // //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// // //         ),
// // //         child: Text(label),
// // //       ),
// // //     );
// // //   }

// // //   Widget _skipButton(VoidCallback onPressed) {
// // //     return Center(
// // //       child: TextButton(
// // //         onPressed: onPressed,
// // //         child: const Text("Skip", style: TextStyle(color: Colors.green)),
// // //       ),
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: Padding(
// // //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
// // //         child: Column(
// // //           children: [
// // //             _stepIndicator(),
// // //             const SizedBox(height: 20),
// // //             Expanded(
// // //               child: IndexedStack(
// // //                 index: _currentStep,
// // //                 children: [
// // //                   // Step 1
// // //                   Column(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       const Text("Let's personalize your experience!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
// // //                       const SizedBox(height: 20),
// // //                       TextField(controller: _nameController, decoration: const InputDecoration(prefixIcon: Icon(Icons.person), hintText: "Your Name", border: OutlineInputBorder())),
// // //                       const SizedBox(height: 10),
// // //                       TextField(controller: _ageController, keyboardType: TextInputType.number, decoration: const InputDecoration(prefixIcon: Icon(Icons.calendar_today), hintText: "Your Age", border: OutlineInputBorder())),
// // //                       const SizedBox(height: 10),
// // //                       Wrap(
// // //                         spacing: 10,
// // //                         children: ["Male", "Female", "Other"].map((g) => ChoiceChip(
// // //                           label: Text(g),
// // //                           selected: _gender == g,
// // //                           onSelected: (_) => setState(() => _gender = g),
// // //                           selectedColor: Colors.green.shade200,
// // //                         )).toList(),
// // //                       ),
// // //                       const Spacer(),
// // //                       _greenButton("Continue", () => setState(() => _currentStep++)),
// // //                     ],
// // //                   ),

// // //                   // Step 2
// // //                   Column(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       const Text("Your Diet Preferences", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
// // //                       const Text("Select all that apply"),
// // //                       const SizedBox(height: 10),
// // //                       Wrap(
// // //                         spacing: 10,
// // //                         runSpacing: 10,
// // //                         children: dietOptions.map((item) => FilterChip(
// // //                           avatar: Icon(item['icon'], color: Colors.green),
// // //                           label: Text(item['label']),
// // //                           selected: _dietPrefs.contains(item['label']),
// // //                           onSelected: (val) {
// // //                             setState(() {
// // //                               if (val) {
// // //                                 _dietPrefs.add(item['label']);
// // //                               } else {
// // //                                 _dietPrefs.remove(item['label']);
// // //                               }
// // //                             });
// // //                           },
// // //                           selectedColor: Colors.green.shade100,
// // //                         )).toList(),
// // //                       ),
// // //                       const SizedBox(height: 10),
// // //                       Row(
// // //                         children: [
// // //                           Expanded(
// // //                             child: TextField(
// // //                               controller: _customDietController,
// // //                               decoration: const InputDecoration(hintText: 'Add custom preference'),
// // //                             ),
// // //                           ),
// // //                           IconButton(
// // //                             icon: const Icon(Icons.add),
// // //                             onPressed: () {
// // //                               final value = _customDietController.text.trim();
// // //                               if (value.isNotEmpty && !_dietPrefs.contains(value)) {
// // //                                 setState(() {
// // //                                   _dietPrefs.add(value);
// // //                                   _customDietController.clear();
// // //                                 });
// // //                               }
// // //                             },
// // //                           )
// // //                         ],
// // //                       ),
// // //                       const Spacer(),
// // //                       _greenButton("Continue", () => setState(() => _currentStep++)),
// // //                       _skipButton(() => setState(() => _currentStep++)),
// // //                     ],
// // //                   ),

// // //                   // Step 3
// // //                   Column(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       const Text("Any food allergies?", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
// // //                       const Text("Select all that apply to you"),
// // //                       const SizedBox(height: 10),
// // //                       Wrap(
// // //                         spacing: 10,
// // //                         runSpacing: 10,
// // //                         children: allergyOptions.map((item) => FilterChip(
// // //                           avatar: Icon(item['icon'], color: Colors.red),
// // //                           label: Row(
// // //                             mainAxisSize: MainAxisSize.min,
// // //                             children: [
// // //                               Text(item['label']),
// // //                               const SizedBox(width: 4),
// // //                               const Icon(Icons.warning, color: Colors.red, size: 16)
// // //                             ],
// // //                           ),
// // //                           selected: _allergies.contains(item['label']),
// // //                           onSelected: _noneAllergySelected ? null : (val) {
// // //                             setState(() {
// // //                               if (val) {
// // //                                 _allergies.add(item['label']);
// // //                               } else {
// // //                                 _allergies.remove(item['label']);
// // //                               }
// // //                             });
// // //                           },
// // //                           selectedColor: Colors.red.shade100,
// // //                         )).toList(),
// // //                       ),
// // //                       const SizedBox(height: 10),
// // //                       Row(
// // //                         children: [
// // //                           Expanded(
// // //                             child: TextField(
// // //                               controller: _customAllergyController,
// // //                               decoration: const InputDecoration(hintText: 'Add custom allergy'),
// // //                             ),
// // //                           ),
// // //                           IconButton(
// // //                             icon: const Icon(Icons.add),
// // //                             onPressed: _noneAllergySelected ? null : () {
// // //                               final value = _customAllergyController.text.trim();
// // //                               if (value.isNotEmpty && !_allergies.contains(value)) {
// // //                                 setState(() {
// // //                                   _allergies.add(value);
// // //                                   _customAllergyController.clear();
// // //                                 });
// // //                               }
// // //                             },
// // //                           )
// // //                         ],
// // //                       ),
// // //                       const SizedBox(height: 10),
// // //                       FilterChip(
// // //                         label: const Text("None"),
// // //                         selected: _noneAllergySelected,
// // //                         onSelected: (val) {
// // //                           setState(() {
// // //                             _noneAllergySelected = val;
// // //                             if (val) _allergies.clear();
// // //                           });
// // //                         },
// // //                         selectedColor: Colors.green,
// // //                       ),
// // //                       const Spacer(),
// // //                       _greenButton("Complete Set up", _submitData),
// // //                     ],
// // //                   ),
// // //                 ],
// // //               ),
// // //             )
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }


// // // lib/pages/onboarding.dart
// // //try to refine the step 1, the entire thing is top oriented and the rest of the page is empty mayeb you can bring it in center 
// // // i want is AS IT IS AS MY SS
// // // - step 2 
// // // the size looks good and but again it is not center alligned ot looks more to left and less to right 
// // // - there are no icons to the boxes its supposed to look appelaing 
// // // the custom thing is working good to know
// // // the font is too thin cant read much 
// // // and same for the allergies
// // // not in the center and 
// // // u can keep the continue buttons long as shown in ss 
// // // import 'package:flutter/material.dart';
// // // import 'dart:convert';

// // // class OnboardingScreen extends StatefulWidget {
// // //   const OnboardingScreen({super.key});

// // //   @override
// // //   State<OnboardingScreen> createState() => _OnboardingScreenState();
// // // }

// // // class _OnboardingScreenState extends State<OnboardingScreen> {
// // //   int _currentStep = 0;

// // //   final TextEditingController _nameController = TextEditingController();
// // //   final TextEditingController _ageController = TextEditingController();
// // //   final TextEditingController _customDietController = TextEditingController();
// // //   final TextEditingController _customAllergyController = TextEditingController();

// // //   String? _gender;
// // //   List<String> _dietPrefs = [];
// // //   List<String> _allergies = [];

// // //   final List<String> dietOptions = [
// // //     'Vegan', 'Vegetarian', 'Jain', 'Eggitarian', 'Keto',
// // //     'Diabetic-Friendly', 'Gluten-Free', 'Organic', 'Halal'
// // //   ];

// // //   final List<String> allergyOptions = [
// // //     'Dairy', 'Gluten', 'Peanuts', 'Shellfish',
// // //     'Eggs', 'Soy', 'Tree nuts', 'Garlic'
// // //   ];

// // //   void _submitData() {
// // //     final payload = {
// // //       "name": _nameController.text.trim(),
// // //       "age": int.tryParse(_ageController.text.trim()) ?? 0,
// // //       "gender": _gender,
// // //       "diet_preferences": _dietPrefs,
// // //       "allergies": _allergies
// // //     };

// // //     print("📦 Submitted Payload: ${jsonEncode(payload)}");
// // //   }

// // //   Widget buildStepIndicator() {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         Padding(
// // //           padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // //           child: Text(
// // //             "Step ${_currentStep + 1} of 3",
// // //             style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
// // //           ),
// // //         ),
// // //         const SizedBox(height: 6),
// // //         Padding(
// // //           padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // //           child: LinearProgressIndicator(
// // //             value: (_currentStep + 1) / 3,
// // //             backgroundColor: Colors.grey.shade300,
// // //             valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
// // //             minHeight: 6,
// // //           ),
// // //         ),
// // //         const SizedBox(height: 16),
// // //       ],
// // //     );
// // //   }

// // //   Widget buildDietChips() {
// // //     return Wrap(
// // //       spacing: 12,
// // //       runSpacing: 12,
// // //       children: [
// // //         ..._dietPrefs.map((diet) => GestureDetector(
// // //               onTap: () => setState(() => _dietPrefs.remove(diet)),
// // //               child: Container(
// // //                 height: 90,
// // //                 width: 160,
// // //                 alignment: Alignment.center,
// // //                 decoration: BoxDecoration(
// // //                   color: Colors.green,
// // //                   borderRadius: BorderRadius.circular(12),
// // //                 ),
// // //                 child: Text(diet, style: const TextStyle(color: Colors.white)),
// // //               ),
// // //             )),
// // //         ...dietOptions.where((d) => !_dietPrefs.contains(d)).map((diet) => GestureDetector(
// // //               onTap: () => setState(() => _dietPrefs.add(diet)),
// // //               child: Container(
// // //                 height: 90,
// // //                 width: 160,
// // //                 alignment: Alignment.center,
// // //                 decoration: BoxDecoration(
// // //                   color: Colors.grey.shade100,
// // //                   border: Border.all(color: Colors.grey),
// // //                   borderRadius: BorderRadius.circular(12),
// // //                 ),
// // //                 child: Text(diet),
// // //               ),
// // //             )),
// // //       ],
// // //     );
// // //   }

// // //   Widget buildAllergyChips() {
// // //     return Wrap(
// // //       spacing: 12,
// // //       runSpacing: 12,
// // //       children: [
// // //         ..._allergies.map((a) => GestureDetector(
// // //               onTap: () {
// // //                 if (_allergies.contains("None")) return;
// // //                 setState(() => _allergies.remove(a));
// // //               },
// // //               child: Container(
// // //                 height: 90,
// // //                 width: 160,
// // //                 alignment: Alignment.center,
// // //                 decoration: BoxDecoration(
// // //                   color: _allergies.contains("None") ? Colors.grey.shade300 : Colors.green,
// // //                   borderRadius: BorderRadius.circular(12),
// // //                 ),
// // //                 child: Text(a, style: const TextStyle(color: Colors.white)),
// // //               ),
// // //             )),
// // //         ...allergyOptions.where((a) => !_allergies.contains(a)).map((a) => GestureDetector(
// // //               onTap: () {
// // //                 if (_allergies.contains("None")) return;
// // //                 setState(() => _allergies.add(a));
// // //               },
// // //               child: Container(
// // //                 height: 90,
// // //                 width: 160,
// // //                 alignment: Alignment.center,
// // //                 decoration: BoxDecoration(
// // //                   color: Colors.grey.shade100,
// // //                   border: Border.all(color: Colors.grey),
// // //                   borderRadius: BorderRadius.circular(12),
// // //                 ),
// // //                 child: Row(
// // //                   mainAxisAlignment: MainAxisAlignment.center,
// // //                   children: [
// // //                     const Icon(Icons.warning_amber_rounded, color: Colors.red),
// // //                     const SizedBox(width: 6),
// // //                     Text(a)
// // //                   ],
// // //                 ),
// // //               ),
// // //             )),
// // //       ],
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.white,
// // //       body: SafeArea(
// // //         child: Padding(
// // //           padding: const EdgeInsets.all(16.0),
// // //           child: SingleChildScrollView(
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 buildStepIndicator(),
// // //                 if (_currentStep == 0) ...[
// // //                   const Text("Let's personalize your experience!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
// // //                   const SizedBox(height: 16),
// // //                   TextField(
// // //                     controller: _nameController,
// // //                     decoration: const InputDecoration(
// // //                       hintText: "Your Name",
// // //                       prefixIcon: Icon(Icons.person_outline),
// // //                       border: OutlineInputBorder(),
// // //                     ),
// // //                   ),
// // //                   const SizedBox(height: 12),
// // //                   TextField(
// // //                     controller: _ageController,
// // //                     keyboardType: TextInputType.number,
// // //                     decoration: const InputDecoration(
// // //                       hintText: "Your Age",
// // //                       prefixIcon: Icon(Icons.calendar_today_outlined),
// // //                       border: OutlineInputBorder(),
// // //                     ),
// // //                   ),
// // //                   const SizedBox(height: 12),
// // //                   Row(
// // //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
// // //                     children: ["Male", "Female", "Other"].map((g) => ChoiceChip(
// // //                       label: Text(g),
// // //                       selected: _gender == g,
// // //                       selectedColor: Colors.green,
// // //                       onSelected: (_) => setState(() => _gender = g),
// // //                     )).toList(),
// // //                   ),
// // //                   const SizedBox(height: 16),
// // //                   ElevatedButton(
// // //                     style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
// // //                     onPressed: () => setState(() => _currentStep = 1),
// // //                     child: const Text("Continue", style: TextStyle(color: Colors.white)),
// // //                   )
// // //                 ] else if (_currentStep == 1) ...[
// // //                   const Text("Your Diet Preferences", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// // //                   const SizedBox(height: 10),
// // //                   buildDietChips(),
// // //                   const SizedBox(height: 12),
// // //                   Row(
// // //                     children: [
// // //                       Expanded(
// // //                         child: TextField(
// // //                           controller: _customDietController,
// // //                           decoration: const InputDecoration(hintText: 'Add custom diet'),
// // //                         ),
// // //                       ),
// // //                       IconButton(
// // //                         icon: const Icon(Icons.add),
// // //                         onPressed: () {
// // //                           final value = _customDietController.text.trim();
// // //                           if (value.isNotEmpty && !_dietPrefs.contains(value)) {
// // //                             setState(() {
// // //                               _dietPrefs.add(value);
// // //                               _customDietController.clear();
// // //                             });
// // //                           }
// // //                         },
// // //                       )
// // //                     ],
// // //                   ),
// // //                   const SizedBox(height: 12),
// // //                   ElevatedButton(
// // //                     style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
// // //                     onPressed: () => setState(() => _currentStep = 2),
// // //                     child: const Text("Continue", style: TextStyle(color: Colors.white)),
// // //                   ),
// // //                   TextButton(
// // //                     onPressed: () => setState(() => _currentStep = 2),
// // //                     child: const Text("Skip", style: TextStyle(color: Colors.green)),
// // //                   )
// // //                 ] else if (_currentStep == 2) ...[
// // //                   const Text("Any food allergies?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// // //                   const SizedBox(height: 10),
// // //                   buildAllergyChips(),
// // //                   const SizedBox(height: 12),
// // //                   Row(
// // //                     children: [
// // //                       Expanded(
// // //                         child: TextField(
// // //                           controller: _customAllergyController,
// // //                           decoration: const InputDecoration(hintText: 'Add custom allergy'),
// // //                         ),
// // //                       ),
// // //                       IconButton(
// // //                         icon: const Icon(Icons.add),
// // //                         onPressed: () {
// // //                           final value = _customAllergyController.text.trim();
// // //                           if (value.isNotEmpty && !_allergies.contains(value)) {
// // //                             setState(() {
// // //                               _allergies.add(value);
// // //                               _customAllergyController.clear();
// // //                             });
// // //                           }
// // //                         },
// // //                       )
// // //                     ],
// // //                   ),
// // //                   const SizedBox(height: 10),
// // //                   ElevatedButton(
// // //                     style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
// // //                     onPressed: _submitData,
// // //                     child: const Text("Complete Set Up", style: TextStyle(color: Colors.white)),
// // //                   ),
// // //                   TextButton(
// // //                     onPressed: () {
// // //                       setState(() => _allergies = ["None"]);
// // //                     },
// // //                     child: const Text("None", style: TextStyle(color: Colors.green)),
// // //                   )
// // //                 ]
// // //               ],
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // lib/pages/onboarding.dart
// //minor changes to the onboarding screen
// //import 'package:flutter/material.dart';
// import 'dart:convert';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   int _currentStep = 0;

//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _customDietController = TextEditingController();
//   final TextEditingController _customAllergyController = TextEditingController();

//   String? _gender;
//   List<String> _dietPrefs = [];
//   List<String> _allergies = [];

//   final List<Map<String, dynamic>> dietOptions = [
//     {'label': 'Vegan', 'icon': Icons.eco},
//     {'label': 'Vegetarian', 'icon': Icons.grass},
//     {'label': 'Jain', 'icon': Icons.spa},
//     {'label': 'Eggitarian', 'icon': Icons.egg_alt},
//     {'label': 'Keto', 'icon': Icons.local_fire_department},
//     {'label': 'Diabetic-Friendly', 'icon': Icons.monitor_heart},
//     {'label': 'Gluten-Free', 'icon': Icons.no_food},
//     {'label': 'Organic', 'icon': Icons.eco_outlined},
//     {'label': 'Halal', 'icon': Icons.verified_user},
//   ];

//   final List<Map<String, dynamic>> allergyOptions = [
//     {'label': 'Dairy', 'icon': Icons.icecream},
//     {'label': 'Gluten', 'icon': Icons.no_food},
//     {'label': 'Peanuts', 'icon': Icons.rice_bowl},
//     {'label': 'Shellfish', 'icon': Icons.set_meal},
//     {'label': 'Eggs', 'icon': Icons.egg},
//     {'label': 'Soy', 'icon': Icons.grain},
//     {'label': 'Tree nuts', 'icon': Icons.park},
//     {'label': 'Garlic', 'icon': Icons.local_florist},
//   ];

//   void _submitData() {
//     final payload = {
//       "name": _nameController.text.trim(),
//       "age": int.tryParse(_ageController.text.trim()) ?? 0,
//       "gender": _gender,
//       "diet_preferences": _dietPrefs,
//       "allergies": _allergies
//     };

//     print("📦 Submitted Payload: ${jsonEncode(payload)}");
//   }

//   Widget buildStepIndicator() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Text(
//             "Step ${_currentStep + 1} of 3",
//             style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//           ),
//         ),
//         const SizedBox(height: 6),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: LinearProgressIndicator(
//             value: (_currentStep + 1) / 3,
//             backgroundColor: Colors.grey.shade300,
//             valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
//             minHeight: 6,
//           ),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }

//   Widget buildDietChips() {
//     return Center(
//       child: Wrap(
//         spacing: 16,
//         runSpacing: 16,
//         alignment: WrapAlignment.center,
//         children: [
//           ..._dietPrefs.map((diet) => GestureDetector(
//                 onTap: () => setState(() => _dietPrefs.remove(diet)),
//                 child: Container(
//                   height: 90,
//                   width: 160,
//                   decoration: BoxDecoration(
//                     color: Colors.green,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Center(
//                     child: Text(diet, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//               )),
//           ...dietOptions.where((d) => !_dietPrefs.contains(d['label'])).map((diet) => GestureDetector(
//                 onTap: () => setState(() => _dietPrefs.add(diet['label'])),
//                 child: Container(
//                   height: 90,
//                   width: 160,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: Colors.grey.shade400),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(diet['icon'], color: Colors.green, size: 28),
//                       const SizedBox(height: 6),
//                       Text(diet['label'], style: const TextStyle(fontWeight: FontWeight.w500))
//                     ],
//                   ),
//                 ),
//               ))
//         ],
//       ),
//     );
//   }

//   Widget buildAllergyChips() {
//     return Center(
//       child: Wrap(
//         spacing: 16,
//         runSpacing: 16,
//         alignment: WrapAlignment.center,
//         children: [
//           ..._allergies.map((a) => GestureDetector(
//                 onTap: () {
//                   if (_allergies.contains("None")) return;
//                   setState(() => _allergies.remove(a));
//                 },
//                 child: Container(
//                   height: 90,
//                   width: 160,
//                   decoration: BoxDecoration(
//                     color: Colors.green,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Center(
//                     child: Text(a, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//               )),
//           ...allergyOptions.where((a) => !_allergies.contains(a['label'])).map((a) => GestureDetector(
//                 onTap: () {
//                   if (_allergies.contains("None")) return;
//                   setState(() => _allergies.add(a['label']));
//                 },
//                 child: Container(
//                   height: 90,
//                   width: 160,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: Colors.grey.shade400),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.warning_amber, color: Colors.red),
//                       const SizedBox(height: 6),
//                       Text(a['label'], style: const TextStyle(fontWeight: FontWeight.w500)),
//                     ],
//                   ),
//                 ),
//               )),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 buildStepIndicator(),
//                 if (_currentStep == 0) ...[
//                   const SizedBox(height: 16),
//                   const Text("Let's personalize your experience!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 20),
//                   TextField(
//                     controller: _nameController,
//                     decoration: const InputDecoration(
//                       hintText: "Your Name",
//                       prefixIcon: Icon(Icons.person_outline),
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   TextField(
//                     controller: _ageController,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(
//                       hintText: "Your Age",
//                       prefixIcon: Icon(Icons.calendar_today_outlined),
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: ["Male", "Female", "Other"].map((g) => ChoiceChip(
//                       label: Text(g),
//                       selected: _gender == g,
//                       selectedColor: Colors.green,
//                       onSelected: (_) => setState(() => _gender = g),
//                     )).toList(),
//                   ),
//                   const SizedBox(height: 30),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 14)),
//                       onPressed: () => setState(() => _currentStep = 1),
//                       child: const Text("Continue", style: TextStyle(color: Colors.white, fontSize: 16)),
//                     ),
//                   )
//                 ] else if (_currentStep == 1) ...[
//                   const Text("Your Diet Preferences", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 6),
//                   const Text("Select all that apply", style: TextStyle(fontSize: 14)),
//                   const SizedBox(height: 20),
//                   buildDietChips(),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: _customDietController,
//                           decoration: const InputDecoration(hintText: 'Add custom diet'),
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.add),
//                         onPressed: () {
//                           final value = _customDietController.text.trim();
//                           if (value.isNotEmpty && !_dietPrefs.contains(value)) {
//                             setState(() {
//                               _dietPrefs.add(value);
//                               _customDietController.clear();
//                             });
//                           }
//                         },
//                       )
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 14)),
//                       onPressed: () => setState(() => _currentStep = 2),
//                       child: const Text("Continue", style: TextStyle(color: Colors.white, fontSize: 16)),
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () => setState(() => _currentStep = 2),
//                     child: const Text("Skip", style: TextStyle(color: Colors.green)),
//                   )
//                 ] else if (_currentStep == 2) ...[
//                   const Text("Any food allergies?", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 6),
//                   const Text("Select all that apply to you", style: TextStyle(fontSize: 14)),
//                   const SizedBox(height: 20),
//                   buildAllergyChips(),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: _customAllergyController,
//                           decoration: const InputDecoration(hintText: 'Add custom allergy'),
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.add),
//                         onPressed: () {
//                           final value = _customAllergyController.text.trim();
//                           if (value.isNotEmpty && !_allergies.contains(value)) {
//                             setState(() {
//                               _allergies.add(value);
//                               _customAllergyController.clear();
//                             });
//                           }
//                         },
//                       )
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 14)),
//                       onPressed: _submitData,
//                       child: const Text("Complete Set up", style: TextStyle(color: Colors.white, fontSize: 16)),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   TextButton(
//                     onPressed: () {
//                       setState(() => _allergies = ["None"]);
//                     },
//                     child: const Text("None", style: TextStyle(color: Colors.green)),
//                   )
//                 ]
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // // lib/pages/onboarding.dart
// // import 'package:flutter/material.dart';
// // // import 'package:http/http.dart' as http;
// // import 'dart:convert';

// // class OnboardingScreen extends StatefulWidget {
// //   const OnboardingScreen({super.key});

// //   @override
// //   State<OnboardingScreen> createState() => _OnboardingScreenState();
// // }

// // class _OnboardingScreenState extends State<OnboardingScreen> {
// //   int _currentStep = 0;

// //   final TextEditingController _nameController = TextEditingController();
// //   final TextEditingController _ageController = TextEditingController();
// //   final TextEditingController _customDietController = TextEditingController();
// //   final TextEditingController _customAllergyController = TextEditingController();

// //   String? _gender;
// //   List<String> _dietPrefs = [];
// //   List<String> _allergies = [];

// //   final List<String> dietOptions = [
// //     'Vegan', 'Vegetarian', 'Jain', 'Eggitarian', 'Keto',
// //     'Diabetic-Friendly', 'Gluten-Free', 'Organic', 'Halal'
// //   ];

// //   final List<String> allergyOptions = [
// //     'Dairy', 'Gluten', 'Peanuts', 'Shellfish',
// //     'Eggs', 'Soy', 'Tree nuts', 'Garlic'
// //   ];

// //   void _submitData() async {
// //     final payload = {
// //       "name": _nameController.text.trim(),
// //       "age": int.tryParse(_ageController.text.trim()) ?? 0,
// //       "gender": _gender,
// //       "diet_preferences": _dietPrefs,
// //       "allergies": _allergies
// //     };

// //     print("\n--- Sending Data to API ---\n${jsonEncode(payload)}\n----------------------------");
// //   }

// //   Widget buildStep1() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         const Text("Step 1 of 3", style: TextStyle(color: Colors.black54)),
// //         const SizedBox(height: 4),
// //         LinearProgressIndicator(
// //           value: 0.33,
// //           color: Colors.green,
// //           backgroundColor: Colors.grey[300],
// //         ),
// //         const SizedBox(height: 20),
// //         const Text("Let's personalize your experience!",
// //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
// //         const SizedBox(height: 20),
// //         TextField(
// //           controller: _nameController,
// //           decoration: const InputDecoration(
// //             prefixIcon: Icon(Icons.person_outline),
// //             labelText: "Your Name",
// //             border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(14)))
// //           ),
// //         ),
// //         const SizedBox(height: 12),
// //         TextField(
// //           controller: _ageController,
// //           keyboardType: TextInputType.number,
// //           decoration: const InputDecoration(
// //             prefixIcon: Icon(Icons.calendar_today),
// //             labelText: "Your Age",
// //             border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(14)))
// //           ),
// //         ),
// //         const SizedBox(height: 16),
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //           children: ["Male", "Female", "Other"].map((g) => ChoiceChip(
// //             label: Text(g),
// //             selected: _gender == g,
// //             onSelected: (_) => setState(() => _gender = g),
// //             backgroundColor: Colors.white,
// //             selectedColor: Color(0xFFE6F4EA),
// //           )).toList(),
// //         ),
// //         const SizedBox(height: 30),
// //         SizedBox(
// //           width: double.infinity,
// //           height: 50,
// //           child: ElevatedButton(
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Colors.green,
// //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
// //             ),
// //             onPressed: () => setState(() => _currentStep++),
// //             child: const Text("Continue", style: TextStyle(color: Colors.white)),
// //           ),
// //         )
// //       ],
// //     );
// //   }

// //   Widget buildStep2() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         const Text("Step 2 of 3", style: TextStyle(color: Colors.black54)),
// //         const SizedBox(height: 4),
// //         LinearProgressIndicator(
// //           value: 0.66,
// //           color: Colors.green,
// //           backgroundColor: Colors.grey[300],
// //         ),
// //         const SizedBox(height: 20),
// //         const Text("Your Diet Preferences",
// //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
// //         const Text("Select all that apply"),
// //         const SizedBox(height: 20),
// //         Wrap(
// //           spacing: 10,
// //           runSpacing: 10,
// //           children: _dietPrefs.map((pref) => _buildChip(pref, selected: true)).toList()
// //             + dietOptions.where((d) => !_dietPrefs.contains(d)).map((pref) => _buildChip(pref)).toList(),
// //         ),
// //         const SizedBox(height: 12),
// //         Row(
// //           children: [
// //             Expanded(
// //               child: TextField(
// //                 controller: _customDietController,
// //                 decoration: const InputDecoration(hintText: "Add custom preference"),
// //               ),
// //             ),
// //             IconButton(
// //               icon: const Icon(Icons.add),
// //               onPressed: () {
// //                 final value = _customDietController.text.trim();
// //                 if (value.isNotEmpty && !_dietPrefs.contains(value)) {
// //                   setState(() {
// //                     _dietPrefs.add(value);
// //                     _customDietController.clear();
// //                   });
// //                 }
// //               },
// //             )
// //           ],
// //         ),
// //         const SizedBox(height: 30),
// //         SizedBox(
// //           width: double.infinity,
// //           height: 50,
// //           child: ElevatedButton(
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Colors.green,
// //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
// //             ),
// //             onPressed: () => setState(() => _currentStep++),
// //             child: const Text("Continue", style: TextStyle(color: Colors.white)),
// //           ),
// //         ),
// //         const SizedBox(height: 12),
// //         Center(
// //           child: TextButton(onPressed: () => setState(() => _currentStep++), child: const Text("Skip")),
// //         )
// //       ],
// //     );
// //   }

// //   Widget buildStep3() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         const Text("Step 3 of 3", style: TextStyle(color: Colors.black54)),
// //         const SizedBox(height: 4),
// //         LinearProgressIndicator(
// //           value: 1,
// //           color: Colors.green,
// //           backgroundColor: Colors.grey[300],
// //         ),
// //         const SizedBox(height: 20),
// //         const Text("Any food allergies?",
// //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
// //         const Text("Select all that apply to you"),
// //         const SizedBox(height: 20),
// //         Wrap(
// //           spacing: 10,
// //           runSpacing: 10,
// //           children: _allergies.map((a) => _buildChip(a, selected: true, isAllergy: true)).toList()
// //             + allergyOptions.where((a) => !_allergies.contains(a)).map((a) => _buildChip(a, isAllergy: true)).toList(),
// //         ),
// //         const SizedBox(height: 12),
// //         Row(
// //           children: [
// //             Expanded(
// //               child: TextField(
// //                 controller: _customAllergyController,
// //                 decoration: const InputDecoration(hintText: "Add custom allergy"),
// //               ),
// //             ),
// //             IconButton(
// //               icon: const Icon(Icons.add),
// //               onPressed: () {
// //                 final val = _customAllergyController.text.trim();
// //                 if (val.isNotEmpty && !_allergies.contains(val)) {
// //                   setState(() {
// //                     _allergies.add(val);
// //                     _customAllergyController.clear();
// //                   });
// //                 }
// //               },
// //             )
// //           ],
// //         ),
// //         const SizedBox(height: 12),
// //         FilterChip(
// //           label: const Text("None"),
// //           selected: _allergies.isEmpty,
// //           onSelected: (_) => setState(() => _allergies.clear()),
// //         ),
// //         const SizedBox(height: 20),
// //         SizedBox(
// //           width: double.infinity,
// //           height: 50,
// //           child: ElevatedButton(
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Colors.green,
// //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
// //             ),
// //             onPressed: _submitData,
// //             child: const Text("Complete Set up", style: TextStyle(color: Colors.white)),
// //           ),
// //         )
// //       ],
// //     );
// //   }

// //   Widget _buildChip(String label, {bool selected = false, bool isAllergy = false}) {
// //     return InkWell(
// //       onTap: () {
// //         setState(() {
// //           if (isAllergy) {
// //             if (_allergies.contains(label)) _allergies.remove(label);
// //             else _allergies.add(label);
// //           } else {
// //             if (_dietPrefs.contains(label)) _dietPrefs.remove(label);
// //             else _dietPrefs.add(label);
// //           }
// //         });
// //       },
// //       child: Container(
// //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
// //         decoration: BoxDecoration(
// //           color: selected
// //               ? isAllergy ? Color(0xFFFFE5E5) : Color(0xFFE6F4EA)
// //               : Colors.white,
// //           borderRadius: BorderRadius.circular(16),
// //           border: Border.all(color: Colors.black12),
// //         ),
// //         child: Row(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             if (isAllergy) Icon(Icons.warning_amber, color: Colors.red, size: 16),
// //             if (isAllergy) const SizedBox(width: 6),
// //             Text(label, style: const TextStyle(fontSize: 14))
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
// //           child: _currentStep == 0
// //               ? buildStep1()
// //               : Column(
// //                   children: [
// //                     buildStep2(),
// //                     if (_currentStep == 2)
// //                       const SizedBox(height: 30),
// //                     if (_currentStep == 2)
// //                       buildStep3(),
// //                   ],
// //                 ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// // // chip size changes


// // // lib/pages/onboarding.dart
// // // import 'package:flutter/material.dart';
// // // // import 'package:http/http.dart' as http;
// // // // import 'dart:convert';

// // // class OnboardingScreen extends StatefulWidget {
// // //   const OnboardingScreen({super.key});

// // //   @override
// // //   State<OnboardingScreen> createState() => _OnboardingScreenState();
// // // }

// // // class _OnboardingScreenState extends State<OnboardingScreen> {
// // //   int _currentStep = 0;

// // //   final TextEditingController _nameController = TextEditingController();
// // //   final TextEditingController _ageController = TextEditingController();
// // //   final TextEditingController _customDietController = TextEditingController();
// // //   final TextEditingController _customAllergyController = TextEditingController();

// // //   String? _gender;
// // //   List<String> _dietPrefs = [];
// // //   List<String> _allergies = [];

// // //   final List<String> dietOptions = [
// // //     'Vegan', 'Vegetarian', 'Jain', 'Eggitarian', 'Keto',
// // //     'Diabetic-Friendly', 'Gluten-Free', 'Organic', 'Halal'
// // //   ];

// // //   final List<String> allergyOptions = [
// // //     'Dairy', 'Gluten', 'Peanuts', 'Shellfish',
// // //     'Eggs', 'Soy', 'Tree nuts', 'Garlic'
// // //   ];

// // //   void _submitData() async {
// // //     final payload = {
// // //       "name": _nameController.text.trim(),
// // //       "age": int.tryParse(_ageController.text.trim()) ?? 0,
// // //       "gender": _gender,
// // //       "diet_preferences": _dietPrefs,
// // //       "allergies": _allergies
// // //     };

// // //     print("Submitted Payload: $payload"); // For testing without backend
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.white,
// // //       body: SafeArea(
// // //         child: SingleChildScrollView(
// // //           padding: const EdgeInsets.all(20),
// // //           child: Column(
// // //             crossAxisAlignment: CrossAxisAlignment.center,
// // //             children: [
// // //               if (_currentStep == 0) _buildStep1(),
// // //               if (_currentStep == 1) _buildStep2(),
// // //               if (_currentStep == 2) _buildStep3(),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildStep1() {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         const Text("Step 1 of 3", style: TextStyle(fontSize: 14, color: Colors.black54)),
// // //         const SizedBox(height: 4),
// // //         LinearProgressIndicator(value: 1 / 3, backgroundColor: Colors.grey[300], color: Colors.green),
// // //         const SizedBox(height: 30),
// // //         const Text(
// // //           "Let's personalize your\nexperience!",
// // //           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
// // //         ),
// // //         const SizedBox(height: 30),
// // //         TextField(
// // //           controller: _nameController,
// // //           decoration: InputDecoration(
// // //             hintText: 'Your Name',
// // //             prefixIcon: const Icon(Icons.person_outline),
// // //             border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
// // //           ),
// // //         ),
// // //         const SizedBox(height: 16),
// // //         TextField(
// // //           controller: _ageController,
// // //           keyboardType: TextInputType.number,
// // //           decoration: InputDecoration(
// // //             hintText: 'Your Age',
// // //             prefixIcon: const Icon(Icons.calendar_today_outlined),
// // //             border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
// // //           ),
// // //         ),
// // //         const SizedBox(height: 16),
// // //         Wrap(
// // //           spacing: 12,
// // //           children: ["Male", "Female", "Other"].map((g) => ChoiceChip(
// // //             label: Text(g),
// // //             selected: _gender == g,
// // //             onSelected: (_) => setState(() => _gender = g),
// // //             selectedColor: Colors.green.shade100,
// // //             backgroundColor: Colors.grey.shade200,
// // //             labelStyle: TextStyle(color: Colors.black),
// // //           )).toList(),
// // //         ),
// // //         const SizedBox(height: 30),
// // //         SizedBox(
// // //           width: double.infinity,
// // //           child: ElevatedButton(
// // //             style: ElevatedButton.styleFrom(
// // //               backgroundColor: Colors.green,
// // //               foregroundColor: Colors.white,
// // //               padding: const EdgeInsets.symmetric(vertical: 14),
// // //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //             ),
// // //             onPressed: () => setState(() => _currentStep++),
// // //             child: const Text("Continue"),
// // //           ),
// // //         )
// // //       ],
// // //     );
// // //   }

// // //   Widget _buildStep2() {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         const SizedBox(height: 30),
// // //         const Text("Step 2 of 3", style: TextStyle(fontSize: 14, color: Colors.black54)),
// // //         const SizedBox(height: 4),
// // //         LinearProgressIndicator(value: 2 / 3, backgroundColor: Colors.grey[300], color: Colors.green),
// // //         const SizedBox(height: 30),
// // //         const Text("Your Diet Preferences", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
// // //         const SizedBox(height: 6),
// // //         const Text("Select all that apply", style: TextStyle(color: Colors.black54)),
// // //         const SizedBox(height: 20),
// // //         Wrap(
// // //           spacing: 12,
// // //           runSpacing: 12,
// // //           children: _dietPrefs.map((diet) => _buildCustomChip(diet, true)).toList()
// // //             + dietOptions.where((d) => !_dietPrefs.contains(d)).map((diet) => _buildCustomChip(diet, false)).toList(),
// // //         ),
// // //         const SizedBox(height: 10),
// // //         Row(
// // //           children: [
// // //             Expanded(
// // //               child: TextField(
// // //                 controller: _customDietController,
// // //                 decoration: const InputDecoration(hintText: 'Add custom preference'),
// // //               ),
// // //             ),
// // //             IconButton(
// // //               icon: const Icon(Icons.add),
// // //               onPressed: () {
// // //                 final value = _customDietController.text.trim();
// // //                 if (value.isNotEmpty && !_dietPrefs.contains(value)) {
// // //                   setState(() {
// // //                     _dietPrefs.add(value);
// // //                     _customDietController.clear();
// // //                   });
// // //                 }
// // //               },
// // //             )
// // //           ],
// // //         ),
// // //         const SizedBox(height: 30),
// // //         SizedBox(
// // //           width: double.infinity,
// // //           child: ElevatedButton(
// // //             style: ElevatedButton.styleFrom(
// // //               backgroundColor: Colors.green,
// // //               foregroundColor: Colors.white,
// // //               padding: const EdgeInsets.symmetric(vertical: 14),
// // //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //             ),
// // //             onPressed: () => setState(() => _currentStep++),
// // //             child: const Text("Continue"),
// // //           ),
// // //         ),
// // //         const SizedBox(height: 10),
// // //         Center(
// // //           child: TextButton(
// // //             onPressed: () => setState(() => _currentStep++),
// // //             child: const Text("Skip", style: TextStyle(color: Colors.green)),
// // //           ),
// // //         )
// // //       ],
// // //     );
// // //   }

// // //   Widget _buildStep3() {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         const SizedBox(height: 30),
// // //         const Text("Step 3 of 3", style: TextStyle(fontSize: 14, color: Colors.black54)),
// // //         const SizedBox(height: 4),
// // //         LinearProgressIndicator(value: 3 / 3, backgroundColor: Colors.grey[300], color: Colors.green),
// // //         const SizedBox(height: 30),
// // //         const Text("Any food allergies?", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
// // //         const SizedBox(height: 6),
// // //         const Text("Select all that apply to you", style: TextStyle(color: Colors.black54)),
// // //         const SizedBox(height: 20),
// // //         Wrap(
// // //           spacing: 12,
// // //           runSpacing: 12,
// // //           children: _allergies.map((a) => _buildAllergyChip(a, true)).toList()
// // //             + allergyOptions.where((a) => !_allergies.contains(a)).map((a) => _buildAllergyChip(a, false)).toList(),
// // //         ),
// // //         const SizedBox(height: 10),
// // //         Row(
// // //           children: [
// // //             Expanded(
// // //               child: TextField(
// // //                 controller: _customAllergyController,
// // //                 decoration: const InputDecoration(hintText: 'Add custom allergy'),
// // //               ),
// // //             ),
// //             IconButton(
// //               icon: const Icon(Icons.add),
// //               onPressed: () {
// //                 final value = _customAllergyController.text.trim();
// //                 if (value.isNotEmpty && !_allergies.contains(value)) {
// //                   setState(() {
// //                     _allergies.add(value);
// //                     _customAllergyController.clear();
// //                   });
// //                 }
// //               },
// //             )
// //           ],
// //         ),
// //         const SizedBox(height: 16),
// //         FilterChip(
// //           label: const Text("None"),
// //           selected: _allergies.isEmpty,
// //           onSelected: (_) => setState(() => _allergies.clear()),
// //           backgroundColor: Colors.grey.shade300,
// //         ),
// //         const SizedBox(height: 30),
// //         SizedBox(
// //           width: double.infinity,
// //           child: ElevatedButton(
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Colors.green,
// //               foregroundColor: Colors.white,
// //               padding: const EdgeInsets.symmetric(vertical: 14),
// //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //             ),
// //             onPressed: _submitData,
// //             child: const Text("Complete Set up"),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildCustomChip(String label, bool selected) {
// //     return GestureDetector(
// //       onTap: () => setState(() {
// //         selected ? _dietPrefs.remove(label) : _dietPrefs.add(label);
// //       }),
// //       child: Container(
// //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
// //         decoration: BoxDecoration(
// //           color: selected ? Colors.green.shade100 : Colors.grey.shade100,
// //           borderRadius: BorderRadius.circular(16),
// //           border: Border.all(color: Colors.grey.shade400),
// //         ),
// //         child: Text(label, style: const TextStyle(fontSize: 14)),
// //       ),
// //     );
// //   }

// //   Widget _buildAllergyChip(String label, bool selected) {
// //     return GestureDetector(
// //       onTap: () => setState(() {
// //         if (_allergies.isEmpty || _allergies.contains(label)) {
// //           selected ? _allergies.remove(label) : _allergies.add(label);
// //         }
// //       }),
// //       child: Container(
// //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
// //         decoration: BoxDecoration(
// //           color: selected ? Colors.red.shade100 : Colors.grey.shade100,
// //           borderRadius: BorderRadius.circular(16),
// //           border: Border.all(color: Colors.grey.shade400),
// //         ),
// //         child: Row(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             Icon(Icons.warning_amber_rounded, color: Colors.red, size: 16),
// //             const SizedBox(width: 6),
// //             Text(label, style: const TextStyle(fontSize: 14)),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// // chip size alag , and allergies ot working correctly 


// // // lib/pages/onboarding.dart
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';

// // class OnboardingScreen extends StatefulWidget {
// //   const OnboardingScreen({super.key});

// //   @override
// //   State<OnboardingScreen> createState() => _OnboardingScreenState();
// // }

// // class _OnboardingScreenState extends State<OnboardingScreen> {
// //   int _currentStep = 0;

// //   final TextEditingController _nameController = TextEditingController();
// //   final TextEditingController _ageController = TextEditingController();
// //   final TextEditingController _customDietController = TextEditingController();
// //   final TextEditingController _customAllergyController = TextEditingController();

// //   String? _gender;
// //   List<String> _dietPrefs = [];
// //   List<String> _allergies = [];

// //   final List<String> dietOptions = [
// //     'Vegan', 'Vegetarian', 'Jain', 'Eggitarian', 'Keto',
// //     'Diabetic-Friendly', 'Gluten-Free', 'Organic', 'Halal'
// //   ];

// //   final List<String> allergyOptions = [
// //     'Dairy', 'Gluten', 'Peanuts', 'Shellfish',
// //     'Eggs', 'Soy', 'Tree nuts', 'Garlic'
// //   ];

// //   void _submitData() async {
// //     final payload = {
// //       "name": _nameController.text.trim(),
// //       "age": int.tryParse(_ageController.text.trim()) ?? 0,
// //       "gender": _gender,
// //       "diet_preferences": _dietPrefs,
// //       "allergies": _allergies
// //     };

// //     print("Submitted Payload: $payload"); // For testing without backend
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           padding: const EdgeInsets.all(20),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               if (_currentStep == 0) _buildStep1(),
// //               if (_currentStep == 1) _buildStep2(),
// //               if (_currentStep == 2) _buildStep3(),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildStep1() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         const Text("Step 1 of 3", style: TextStyle(fontSize: 14, color: Colors.black54)),
// //         const SizedBox(height: 4),
// //         LinearProgressIndicator(value: 1 / 3, backgroundColor: Colors.grey[300], color: Colors.green),
// //         const SizedBox(height: 30),
// //         const Text(
// //           "Let's personalize your\nexperience!",
// //           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
// //         ),
// //         const SizedBox(height: 30),
// //         TextField(
// //           controller: _nameController,
// //           decoration: InputDecoration(
// //             hintText: 'Your Name',
// //             prefixIcon: const Icon(Icons.person_outline),
// //             border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
// //           ),
// //         ),
// //         const SizedBox(height: 16),
// //         TextField(
// //           controller: _ageController,
// //           keyboardType: TextInputType.number,
// //           decoration: InputDecoration(
// //             hintText: 'Your Age',
// //             prefixIcon: const Icon(Icons.calendar_today_outlined),
// //             border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
// //           ),
// //         ),
// //         const SizedBox(height: 16),
// //         Wrap(
// //           spacing: 12,
// //           children: ["Male", "Female", "Other"].map((g) => ChoiceChip(
// //             label: Text(g),
// //             selected: _gender == g,
// //             onSelected: (_) => setState(() => _gender = g),
// //             selectedColor: Colors.green.shade100,
// //             backgroundColor: Colors.grey.shade200,
// //             labelStyle: TextStyle(color: Colors.black),
// //           )).toList(),
// //         ),
// //         const SizedBox(height: 30),
// //         SizedBox(
// //           width: double.infinity,
// //           child: ElevatedButton(
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Colors.green,
// //               foregroundColor: Colors.white,
// //               padding: const EdgeInsets.symmetric(vertical: 14),
// //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //             ),
// //             onPressed: () => setState(() => _currentStep++),
// //             child: const Text("Continue"),
// //           ),
// //         )
// //       ],
// //     );
// //   }

// //   Widget _buildStep2() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         const SizedBox(height: 30),
// //         const Text("Step 2 of 3", style: TextStyle(fontSize: 14, color: Colors.black54)),
// //         const SizedBox(height: 4),
// //         LinearProgressIndicator(value: 2 / 3, backgroundColor: Colors.grey[300], color: Colors.green),
// //         const SizedBox(height: 30),
// //         const Text("Your Diet Preferences", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
// //         const SizedBox(height: 6),
// //         const Text("Select all that apply", style: TextStyle(color: Colors.black54)),
// //         const SizedBox(height: 20),
// //         Wrap(
// //           spacing: 12,
// //           runSpacing: 12,
// //           children: _dietPrefs.map((diet) => _buildDietChip(diet, true)).toList()
// //             + dietOptions.where((d) => !_dietPrefs.contains(d)).map((diet) => _buildDietChip(diet, false)).toList(),
// //         ),
// //         const SizedBox(height: 10),
// //         Row(
// //           children: [
// //             Expanded(
// //               child: TextField(
// //                 controller: _customDietController,
// //                 decoration: const InputDecoration(hintText: 'Add custom preference'),
// //               ),
// //             ),
// //             IconButton(
// //               icon: const Icon(Icons.add),
// //               onPressed: () {
// //                 final value = _customDietController.text.trim();
// //                 if (value.isNotEmpty && !_dietPrefs.contains(value)) {
// //                   setState(() {
// //                     _dietPrefs.add(value);
// //                     _customDietController.clear();
// //                   });
// //                 }
// //               },
// //             )
// //           ],
// //         ),
// //         const SizedBox(height: 30),
// //         SizedBox(
// //           width: double.infinity,
// //           child: ElevatedButton(
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Colors.green,
// //               foregroundColor: Colors.white,
// //               padding: const EdgeInsets.symmetric(vertical: 14),
// //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //             ),
// //             onPressed: () => setState(() => _currentStep++),
// //             child: const Text("Continue"),
// //           ),
// //         ),
// //         const SizedBox(height: 10),
// //         Center(
// //           child: TextButton(
// //             onPressed: () => setState(() => _currentStep++),
// //             child: const Text("Skip", style: TextStyle(color: Colors.green)),
// //           ),
// //         )
// //       ],
// //     );
// //   }

// //   Widget _buildStep3() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         const SizedBox(height: 30),
// //         const Text("Step 3 of 3", style: TextStyle(fontSize: 14, color: Colors.black54)),
// //         const SizedBox(height: 4),
// //         LinearProgressIndicator(value: 3 / 3, backgroundColor: Colors.grey[300], color: Colors.green),
// //         const SizedBox(height: 30),
// //         const Text("Any food allergies?", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
// //         const SizedBox(height: 6),
// //         const Text("Select all that apply to you", style: TextStyle(color: Colors.black54)),
// //         const SizedBox(height: 20),
// //         Wrap(
// //           spacing: 12,
// //           runSpacing: 12,
// //           children: _allergies.map((a) => _buildAllergyChip(a, true)).toList()
// //             + allergyOptions.where((a) => !_allergies.contains(a)).map((a) => _buildAllergyChip(a, false)).toList(),
// //         ),
// //         const SizedBox(height: 10),
// //         Row(
// //           children: [
// //             Expanded(
// //               child: TextField(
// //                 controller: _customAllergyController,
// //                 decoration: const InputDecoration(hintText: 'Add custom allergy'),
// //               ),
// //             ),
// //             IconButton(
// //               icon: const Icon(Icons.add),
// //               onPressed: () {
// //                 final value = _customAllergyController.text.trim();
// //                 if (value.isNotEmpty && !_allergies.contains(value)) {
// //                   setState(() {
// //                     _allergies.add(value);
// //                     _customAllergyController.clear();
// //                   });
// //                 }
// //               },
// //             )
// //           ],
// //         ),
// //         const SizedBox(height: 16),
// //         FilterChip(
// //           label: const Text("None"),
// //           selected: _allergies.isEmpty,
// //           onSelected: (_) => setState(() => _allergies.clear()),
// //           backgroundColor: Colors.grey.shade300,
// //         ),
// //         const SizedBox(height: 30),
// //         SizedBox(
// //           width: double.infinity,
// //           child: ElevatedButton(
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Colors.green,
// //               foregroundColor: Colors.white,
// //               padding: const EdgeInsets.symmetric(vertical: 14),
// //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //             ),
// //             onPressed: _submitData,
// //             child: const Text("Complete Set up"),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildDietChip(String label, bool selected) {
// //     return GestureDetector(
// //       onTap: () => setState(() {
// //         selected ? _dietPrefs.remove(label) : _dietPrefs.add(label);
// //       }),
// //       child: Container(
// //         height: 90,
// //         width: 160,
// //         alignment: Alignment.center,
// //         decoration: BoxDecoration(
// //           color: selected ? Colors.green : Colors.grey.shade100,
// //           borderRadius: BorderRadius.circular(12),
// //           border: Border.all(color: Colors.grey),
// //         ),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             const Icon(Icons.restaurant_menu, size: 20, color: Colors.black54),
// //             const SizedBox(height: 8),
// //             Text(label, style: const TextStyle(fontSize: 14, color: Colors.black)),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildAllergyChip(String label, bool selected) {
// //     return GestureDetector(
// //       onTap: () => setState(() {
// //         if (_allergies.isEmpty || _allergies.contains(label)) {
// //           selected ? _allergies.remove(label) : _allergies.add(label);
// //         }
// //       }),
// //       child: Container(
// //         height: 90,
// //         width: 160,
// //         alignment: Alignment.center,
// //         decoration: BoxDecoration(
// //           color: selected ? Colors.red.shade100 : Colors.grey.shade100,
// //           borderRadius: BorderRadius.circular(12),
// //           border: Border.all(color: Colors.grey),
// //         ),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             const Icon(Icons.warning_amber_rounded, color: Colors.red),
// //             const SizedBox(height: 6),
// //             Text(label, style: const TextStyle(fontSize: 14)),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }




//unnecessary changes, if else fails run this for demo
// import 'package:flutter/material.dart';
// import 'dart:convert';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   int _currentStep = 0;

//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _customDietController = TextEditingController();
//   final TextEditingController _customAllergyController = TextEditingController();

//   String? _gender;
//   List<String> _dietPrefs = [];
//   List<String> _allergies = [];

//   final List<Map<String, dynamic>> dietOptions = [
//     {'label': 'Vegan', 'icon': Icons.eco},
//     {'label': 'Vegetarian', 'icon': Icons.grass},
//     {'label': 'Jain', 'icon': Icons.spa},
//     {'label': 'Eggitarian', 'icon': Icons.egg_alt},
//     {'label': 'Keto', 'icon': Icons.local_fire_department},
//     {'label': 'Diabetic-Friendly', 'icon': Icons.monitor_heart},
//     {'label': 'Gluten-Free', 'icon': Icons.no_food},
//     {'label': 'Organic', 'icon': Icons.eco_outlined},
//     {'label': 'Halal', 'icon': Icons.verified_user},
//   ];

//   final List<Map<String, dynamic>> allergyOptions = [
//     {'label': 'Dairy', 'icon': Icons.icecream},
//     {'label': 'Gluten', 'icon': Icons.no_food},
//     {'label': 'Peanuts', 'icon': Icons.rice_bowl},
//     {'label': 'Shellfish', 'icon': Icons.set_meal},
//     {'label': 'Eggs', 'icon': Icons.egg},
//     {'label': 'Soy', 'icon': Icons.grain},
//     {'label': 'Tree nuts', 'icon': Icons.park},
//     {'label': 'Garlic', 'icon': Icons.local_florist},
//   ];

//   void _submitData() {
//     final payload = {
//       "name": _nameController.text.trim(),
//       "age": int.tryParse(_ageController.text.trim()) ?? 0,
//       "gender": _gender,
//       "diet_preferences": _dietPrefs,
//       "allergies": _allergies
//     };

//     print("📦 Submitted Payload: ${jsonEncode(payload)}");
//   }

//   Widget buildStepIndicator() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Text(
//             "Step ${_currentStep + 1} of 3",
//             style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//           ),
//         ),
//         const SizedBox(height: 6),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: LinearProgressIndicator(
//             value: (_currentStep + 1) / 3,
//             backgroundColor: Colors.grey.shade300,
//             valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
//             minHeight: 6,
//           ),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }

//   Widget buildDietChips() {
//     return Center(
//       child: Wrap(
//         spacing: 16,
//         runSpacing: 16,
//         alignment: WrapAlignment.center,
//         children: [
//           ..._dietPrefs.map((diet) => GestureDetector(
//                 onTap: () => setState(() => _dietPrefs.remove(diet)),
//                 child: Container(
//                   height: 90,
//                   width: 160,
//                   decoration: BoxDecoration(
//                     color: Colors.green.shade100,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Center(
//                     child: Text(diet, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//               )),
//           ...dietOptions.where((d) => !_dietPrefs.contains(d['label'])).map((diet) => GestureDetector(
//                 onTap: () => setState(() => _dietPrefs.add(diet['label'])),
//                 child: Container(
//                   height: 90,
//                   width: 160,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: Colors.grey.shade400),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(diet['icon'], color: Colors.green, size: 28),
//                       const SizedBox(height: 6),
//                       Text(diet['label'], style: const TextStyle(fontWeight: FontWeight.w500))
//                     ],
//                   ),
//                 ),
//               ))
//         ],
//       ),
//     );
//   }

//   Widget buildAllergyChips() {
//     return Center(
//       child: Wrap(
//         spacing: 16,
//         runSpacing: 16,
//         alignment: WrapAlignment.center,
//         children: [
//           ..._allergies.map((a) => GestureDetector(
//                 onTap: () {
//                   if (_allergies.contains("None")) return;
//                   setState(() => _allergies.remove(a));
//                 },
//                 child: Container(
//                   height: 90,
//                   width: 160,
//                   decoration: BoxDecoration(
//                     color: Colors.red.shade100,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Center(
//                     child: Text(a, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//               )),
//           ...allergyOptions.where((a) => !_allergies.contains(a['label'])).map((a) => GestureDetector(
//                 onTap: () {
//                   if (_allergies.contains("None")) return;
//                   setState(() => _allergies.add(a['label']));
//                 },
//                 child: Container(
//                   height: 90,
//                   width: 160,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: Colors.grey.shade400),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.warning_amber, color: Colors.red),
//                       const SizedBox(height: 6),
//                       Text(a['label'], style: const TextStyle(fontWeight: FontWeight.w500)),
//                     ],
//                   ),
//                 ),
//               )),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 buildStepIndicator(),
//                 if (_currentStep == 0) ...[
//                   const SizedBox(height: 16),
//                   const Text("Let's personalize your experience!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 20),
//                   TextField(
//                     controller: _nameController,
//                     decoration: const InputDecoration(
//                       hintText: "Your Name",
//                       prefixIcon: Icon(Icons.person_outline),
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   TextField(
//                     controller: _ageController,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(
//                       hintText: "Your Age",
//                       prefixIcon: Icon(Icons.calendar_today_outlined),
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: ["Male", "Female", "Other"].map((g) => ChoiceChip(
//                       label: Text(g),
//                       selected: _gender == g,
//                       selectedColor: Colors.green,
//                       onSelected: (_) => setState(() => _gender = g),
//                     )).toList(),
//                   ),
//                   const SizedBox(height: 30),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 14)),
//                       onPressed: () => setState(() => _currentStep = 1),
//                       child: const Text("Continue", style: TextStyle(color: Colors.white, fontSize: 16)),
//                     ),
//                   )
//                 ] else if (_currentStep == 1) ...[
//                   const Text("Your Diet Preferences", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 6),
//                   const Text("Select all that apply", style: TextStyle(fontSize: 14)),
//                   const SizedBox(height: 20),
//                   buildDietChips(),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: _customDietController,
//                           decoration: const InputDecoration(hintText: 'Add custom diet'),
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.add),
//                         onPressed: () {
//                           final value = _customDietController.text.trim();
//                           if (value.isNotEmpty && !_dietPrefs.contains(value)) {
//                             setState(() {
//                               _dietPrefs.add(value);
//                               _customDietController.clear();
//                             });
//                           }
//                         },
//                       )
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 14)),
//                       onPressed: () => setState(() => _currentStep = 2),
//                       child: const Text("Continue", style: TextStyle(color: Colors.white, fontSize: 16)),
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () => setState(() => _currentStep = 2),
//                     child: const Text("Skip", style: TextStyle(color: Colors.green)),
//                   )
//                 ] else if (_currentStep == 2) ...[
//                   const Text("Any food allergies?", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 6),
//                   const Text("Select all that apply to you", style: TextStyle(fontSize: 14)),
//                   const SizedBox(height: 20),
//                   buildAllergyChips(),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: _customAllergyController,
//                           decoration: const InputDecoration(hintText: 'Add custom allergy'),
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.add),
//                         onPressed: () {
//                           final value = _customAllergyController.text.trim();
//                           if (value.isNotEmpty && !_allergies.contains(value)) {
//                             setState(() {
//                               _allergies.add(value);
//                               _customAllergyController.clear();
//                             });
//                           }
//                         },
//                       )
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   TextButton(
//                     onPressed: () {
//                       setState(() => _allergies = ["None"]);
//                     },
//                     child: const Text("None", style: TextStyle(color: Colors.green)),
//                   ),
//                   const SizedBox(height: 10),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 14)),
//                       onPressed: _submitData,
//                       child: const Text("Complete Set up", style: TextStyle(color: Colors.white, fontSize: 16)),
//                     ),
//                   )
//                 ]
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


//works fine only changes in the step 1 for next version , show this for demo
// import 'package:flutter/material.dart';
// import 'dart:convert';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   int _currentStep = 0;

//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _customDietController = TextEditingController();
//   final TextEditingController _customAllergyController = TextEditingController();

//   String? _gender;
//   List<String> _dietPrefs = [];
//   List<String> _allergies = [];

//   final List<Map<String, dynamic>> dietOptions = [
//     {'label': 'Vegan', 'icon': Icons.eco},
//     {'label': 'Vegetarian', 'icon': Icons.grass},
//     {'label': 'Jain', 'icon': Icons.spa},
//     {'label': 'Eggitarian', 'icon': Icons.egg_alt},
//     {'label': 'Keto', 'icon': Icons.local_fire_department},
//     {'label': 'Diabetic-Friendly', 'icon': Icons.monitor_heart},
//     {'label': 'Gluten-Free', 'icon': Icons.no_food},
//     {'label': 'Organic', 'icon': Icons.eco_outlined},
//     {'label': 'Halal', 'icon': Icons.verified_user},
//   ];

//   final List<Map<String, dynamic>> allergyOptions = [
//     {'label': 'Dairy', 'icon': Icons.icecream},
//     {'label': 'Gluten', 'icon': Icons.no_food},
//     {'label': 'Peanuts', 'icon': Icons.rice_bowl},
//     {'label': 'Shellfish', 'icon': Icons.set_meal},
//     {'label': 'Eggs', 'icon': Icons.egg},
//     {'label': 'Soy', 'icon': Icons.grain},
//     {'label': 'Tree nuts', 'icon': Icons.park},
//     {'label': 'Garlic', 'icon': Icons.local_florist},
//   ];

//   void _submitData() {
//     final payload = {
//       "name": _nameController.text.trim(),
//       "age": int.tryParse(_ageController.text.trim()) ?? 0,
//       "gender": _gender,
//       "diet_preferences": _dietPrefs,
//       "allergies": _allergies.contains("None") ? [] : _allergies
//     };

//     print("📦 Submitted Payload: ${jsonEncode(payload)}");
//   }

//   Widget buildStepIndicator() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Text(
//             "Step ${_currentStep + 1} of 3",
//             style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//           ),
//         ),
//         const SizedBox(height: 6),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: LinearProgressIndicator(
//             value: (_currentStep + 1) / 3,
//             backgroundColor: Colors.grey.shade300,
//             valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
//             minHeight: 6,
//           ),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }

//   Widget buildDietChips() {
//     return Center(
//       child: Wrap(
//         spacing: 16,
//         runSpacing: 16,
//         alignment: WrapAlignment.center,
//         children: [
//           ..._dietPrefs.map((diet) => GestureDetector(
//                 onTap: () => setState(() => _dietPrefs.remove(diet)),
//                 child: Container(
//                   height: 90,
//                   width: 160,
//                   decoration: BoxDecoration(
//                     color: Colors.green.shade100,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Center(
//                     child: Text(diet, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//               )),
//           ...dietOptions.where((d) => !_dietPrefs.contains(d['label'])).map((diet) => GestureDetector(
//                 onTap: () => setState(() => _dietPrefs.add(diet['label'])),
//                 child: Container(
//                   height: 90,
//                   width: 160,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: Colors.grey.shade400),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(diet['icon'], color: Colors.green, size: 28),
//                       const SizedBox(height: 6),
//                       Text(diet['label'], style: const TextStyle(fontWeight: FontWeight.w500))
//                     ],
//                   ),
//                 ),
//               ))
//         ],
//       ),
//     );
//   }

//   Widget buildAllergyChips() {
//     return Center(
//       child: Wrap(
//         spacing: 16,
//         runSpacing: 16,
//         alignment: WrapAlignment.center,
//         children: [
//           ..._allergies.map((a) => GestureDetector(
//                 onTap: () {
//                   if (_allergies.contains("None")) return;
//                   setState(() => _allergies.remove(a));
//                 },
//                 child: Container(
//                   height: 90,
//                   width: 160,
//                   decoration: BoxDecoration(
//                     color: Colors.red.shade100,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Center(
//                     child: Text(a, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//               )),
//           ...allergyOptions.where((a) => !_allergies.contains(a['label'])).map((a) => GestureDetector(
//                 onTap: () {
//                   if (_allergies.contains("None")) return;
//                   setState(() => _allergies.add(a['label']));
//                 },
//                 child: Container(
//                   height: 90,
//                   width: 160,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: Colors.grey.shade400),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.warning_amber, color: Colors.red),
//                       const SizedBox(height: 6),
//                       Text(a['label'], style: const TextStyle(fontWeight: FontWeight.w500)),
//                     ],
//                   ),
//                 ),
//               )),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 buildStepIndicator(),
//                 if (_currentStep == 0) ...[
//                   const SizedBox(height: 16),
//                   const Text("Let's personalize your experience!", textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 20),
//                   TextField(
//                     controller: _nameController,
//                     decoration: const InputDecoration(
//                       hintText: "Your Name",
//                       prefixIcon: Icon(Icons.person_outline),
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   TextField(
//                     controller: _ageController,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(
//                       hintText: "Your Age",
//                       prefixIcon: Icon(Icons.calendar_today_outlined),
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: ["Male", "Female", "Other"].map((g) => ChoiceChip(
//                       label: Text(g),
//                       selected: _gender == g,
//                       selectedColor: Colors.green,
//                       onSelected: (_) => setState(() => _gender = g),
//                     )).toList(),
//                   ),
//                   const SizedBox(height: 30),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 14)),
//                       onPressed: () => setState(() => _currentStep = 1),
//                       child: const Text("Continue", style: TextStyle(color: Colors.white, fontSize: 16)),
//                     ),
//                   )
//                 ] else if (_currentStep == 1) ...[
//                   const Text("Your Diet Preferences", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 6),
//                   const Text("Select all that apply", style: TextStyle(fontSize: 14)),
//                   const SizedBox(height: 20),
//                   buildDietChips(),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: _customDietController,
//                           decoration: const InputDecoration(hintText: 'Add custom diet'),
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.add),
//                         onPressed: () {
//                           final value = _customDietController.text.trim();
//                           if (value.isNotEmpty && !_dietPrefs.contains(value)) {
//                             setState(() {
//                               _dietPrefs.add(value);
//                               _customDietController.clear();
//                             });
//                           }
//                         },
//                       )
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 14)),
//                       onPressed: () => setState(() => _currentStep = 2),
//                       child: const Text("Continue", style: TextStyle(color: Colors.white, fontSize: 16)),
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () => setState(() => _currentStep = 2),
//                     child: const Text("Skip", style: TextStyle(color: Colors.green)),
//                   )
//                 ] else if (_currentStep == 2) ...[
//                   const Text("Any food allergies?", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 6),
//                   const Text("Select all that apply to you", style: TextStyle(fontSize: 14)),
//                   const SizedBox(height: 20),
//                   buildAllergyChips(),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: _customAllergyController,
//                           decoration: const InputDecoration(hintText: 'Add custom allergy'),
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.add),
//                         onPressed: () {
//                           final value = _customAllergyController.text.trim();
//                           if (value.isNotEmpty && !_allergies.contains(value)) {
//                             setState(() {
//                               _allergies.add(value);
//                               _customAllergyController.clear();
//                             });
//                           }
//                         },
//                       )
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   TextButton(
//                     onPressed: () {
//                       setState(() => _allergies = ["None"]);
//                     },
//                     child: const Text("None", style: TextStyle(color: Colors.green)),
//                   ),
//                   const SizedBox(height: 10),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 14)),
//                       onPressed: _submitData,
//                       child: const Text("Complete Set up", style: TextStyle(color: Colors.white, fontSize: 16)),
//                     ),
//                   )
//                 ]
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'dart:convert';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   int _currentStep = 0;

//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _customDietController = TextEditingController();
//   final TextEditingController _customAllergyController = TextEditingController();

//   String? _gender;
//   List<String> _dietPrefs = [];
//   List<String> _allergies = [];

//   final List<Map<String, dynamic>> dietOptions = [
//     {'label': 'Vegan', 'icon': Icons.eco},
//     {'label': 'Vegetarian', 'icon': Icons.grass},
//     {'label': 'Jain', 'icon': Icons.spa},
//     {'label': 'Eggitarian', 'icon': Icons.egg_alt},
//     {'label': 'Keto', 'icon': Icons.local_fire_department},
//     {'label': 'Diabetic-Friendly', 'icon': Icons.monitor_heart},
//     {'label': 'Gluten-Free', 'icon': Icons.no_food},
//     {'label': 'Organic', 'icon': Icons.eco_outlined},
//     {'label': 'Halal', 'icon': Icons.verified_user},
//   ];

//   final List<Map<String, dynamic>> allergyOptions = [
//     {'label': 'Dairy', 'icon': Icons.icecream},
//     {'label': 'Gluten', 'icon': Icons.no_food},
//     {'label': 'Peanuts', 'icon': Icons.rice_bowl},
//     {'label': 'Shellfish', 'icon': Icons.set_meal},
//     {'label': 'Eggs', 'icon': Icons.egg},
//     {'label': 'Soy', 'icon': Icons.grain},
//     {'label': 'Tree nuts', 'icon': Icons.park},
//     {'label': 'Garlic', 'icon': Icons.local_florist},
//   ];

//   void _submitData() {
//     final payload = {
//       "name": _nameController.text.trim(),
//       "age": int.tryParse(_ageController.text.trim()) ?? 0,
//       "gender": _gender,
//       "diet_preferences": _dietPrefs,
//       "allergies": _allergies.contains("None") ? [] : _allergies
//     };

//     print("📦 Submitted Payload: ${jsonEncode(payload)}");
//   }

//   Widget buildStepIndicator() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Text(
//             "Step ${_currentStep + 1} of 3",
//             style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//           ),
//         ),
//         const SizedBox(height: 6),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: LinearProgressIndicator(
//             value: (_currentStep + 1) / 3,
//             backgroundColor: Colors.grey.shade300,
//             valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
//             minHeight: 6,
//           ),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }

//   Widget buildDietChips() {
//     return Center(
//       child: Wrap(
//         spacing: 16,
//         runSpacing: 16,
//         alignment: WrapAlignment.center,
//         children: [
//           ..._dietPrefs.map((diet) => GestureDetector(
//                 onTap: () => setState(() => _dietPrefs.remove(diet)),
//                 child: Container(
//                   height: 90,
//                   width: 160,
//                   decoration: BoxDecoration(
//                     color: Colors.green.shade100,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Center(
//                     child: Text(diet, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//               )),
//           ...dietOptions.where((d) => !_dietPrefs.contains(d['label'])).map((diet) => GestureDetector(
//                 onTap: () => setState(() => _dietPrefs.add(diet['label'])),
//                 child: Container(
//                   height: 90,
//                   width: 160,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: Colors.grey.shade400),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(diet['icon'], color: Colors.green, size: 28),
//                       const SizedBox(height: 6),
//                       Text(diet['label'], style: const TextStyle(fontWeight: FontWeight.w500))
//                     ],
//                   ),
//                 ),
//               ))
//         ],
//       ),
//     );
//   }

//   Widget buildAllergyChips() {
//     return Center(
//       child: Wrap(
//         spacing: 16,
//         runSpacing: 16,
//         alignment: WrapAlignment.center,
//         children: [
//           ..._allergies.map((a) => GestureDetector(
//                 onTap: () {
//                   if (_allergies.contains("None")) return;
//                   setState(() => _allergies.remove(a));
//                 },
//                 child: Container(
//                   height: 90,
//                   width: 160,
//                   decoration: BoxDecoration(
//                     color: Colors.red.shade100,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Center(
//                     child: Text(a, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//               )),
//           ...allergyOptions.where((a) => !_allergies.contains(a['label'])).map((a) => GestureDetector(
//                 onTap: () {
//                   if (_allergies.contains("None")) return;
//                   setState(() => _allergies.add(a['label']));
//                 },
//                 child: Container(
//                   height: 90,
//                   width: 160,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: Colors.grey.shade400),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.healing, color: Colors.red),
//                       const SizedBox(height: 6),
//                       Text(a['label'], style: const TextStyle(fontWeight: FontWeight.w500)),
//                     ],
//                   ),
//                 ),
//               )),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 buildStepIndicator(),
//                 if (_currentStep == 0) ...[
//                   const SizedBox(height: 16),
//                   const Text(
//                     "Let's personalize your experience!",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 20),
//                   SizedBox(
//                     height: 48,
//                     child: TextField(
//                       controller: _nameController,
//                       decoration: const InputDecoration(
//                         hintText: "Your Name",
//                         prefixIcon: Icon(Icons.person_outline),
//                         border: OutlineInputBorder(),
//                         contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   SizedBox(
//                     height: 48,
//                     child: TextField(
//                       controller: _ageController,
//                       keyboardType: TextInputType.number,
//                       decoration: const InputDecoration(
//                         hintText: "Your Age",
//                         prefixIcon: Icon(Icons.calendar_today_outlined),
//                         border: OutlineInputBorder(),
//                         contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Wrap(
//                     spacing: 12,
//                     children: ["Male", "Female", "Other"].map((g) => ChoiceChip(
//                       label: Text(g),
//                       selected: _gender == g,
//                       selectedColor: Colors.green,
//                       onSelected: (_) => setState(() => _gender = g),
//                     )).toList(),
//                   ),
//                   const SizedBox(height: 30),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.green,
//                           padding: const EdgeInsets.symmetric(vertical: 14)),
//                       onPressed: () => setState(() => _currentStep = 1),
//                       child: const Text("Continue",
//                           style: TextStyle(color: Colors.white, fontSize: 16)),
//                     ),
//                   )
//                 ] else if (_currentStep == 1) ...[
//                   const Text("Your Diet Preferences", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 6),
//                   const Text("Select all that apply", style: TextStyle(fontSize: 14)),
//                   const SizedBox(height: 20),
//                   buildDietChips(),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: _customDietController,
//                           decoration: const InputDecoration(hintText: 'Add custom diet'),
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.add),
//                         onPressed: () {
//                           final value = _customDietController.text.trim();
//                           if (value.isNotEmpty && !_dietPrefs.contains(value)) {
//                             setState(() {
//                               _dietPrefs.add(value);
//                               _customDietController.clear();
//                             });
//                           }
//                         },
//                       )
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 14)),
//                       onPressed: () => setState(() => _currentStep = 2),
//                       child: const Text("Continue", style: TextStyle(color: Colors.white, fontSize: 16)),
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () => setState(() => _currentStep = 2),
//                     child: const Text("Skip", style: TextStyle(color: Colors.green)),
//                   )
//                 ] else if (_currentStep == 2) ...[
//                   const Text("Any food allergies?", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 6),
//                   const Text("Select all that apply to you", style: TextStyle(fontSize: 14)),
//                   const SizedBox(height: 20),
//                   buildAllergyChips(),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: _customAllergyController,
//                           decoration: const InputDecoration(hintText: 'Add custom allergy'),
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.add),
//                         onPressed: () {
//                           final value = _customAllergyController.text.trim();
//                           if (value.isNotEmpty && !_allergies.contains(value)) {
//                             setState(() {
//                               _allergies.add(value);
//                               _customAllergyController.clear();
//                             });
//                           }
//                         },
//                       )
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   TextButton(
//                     onPressed: () {
//                       setState(() => _allergies = ["None"]);
//                     },
//                     child: const Text("None", style: TextStyle(color: Colors.green)),
//                   ),
//                   const SizedBox(height: 10),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 14)),
//                       onPressed: _submitData,
//                       child: const Text("Complete Set up", style: TextStyle(color: Colors.white, fontSize: 16)),
//                     ),
//                   )
//                 ]
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//most valid ha 


import 'package:flutter/material.dart';
import 'dart:convert';
import 'dashboard.dart';

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
  final TextEditingController _customAllergyController = TextEditingController();

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

  void _submitData() {
    final payload = {
      "name": _nameController.text.trim(),
      "age": int.tryParse(_ageController.text.trim()) ?? 0,
      "gender": _gender,
      "diet_preferences": _dietPrefs,
      "allergies": _allergies.contains("None") ? [] : _allergies
    };

    print("📦 Submitted Payload: ${jsonEncode(payload)}");
     Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => DashboardScreen()),
  );
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
                    child: Text(diet, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
              )),
          ...dietOptions.where((d) => !_dietPrefs.contains(d['label'])).map((diet) => GestureDetector(
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
                      Text(diet['label'], style: const TextStyle(fontWeight: FontWeight.w500))
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
                      Text(a, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              )),
          ...allergyOptions.where((a) => !_allergies.contains(a['label'])).map((a) => GestureDetector(
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
                      Text(a['label'], style: const TextStyle(fontWeight: FontWeight.w500)),
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
                  const Text("Let's personalize your experience!", textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 48,
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: "Your Name",
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
                        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    children: ["Male", "Female", "Other"].map((g) => ChoiceChip(
                      label: Text(g),
                      selected: _gender == g,
                      selectedColor: Colors.green,
                      onSelected: (_) => setState(() => _gender = g),
                    )).toList(),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 14)),
                      onPressed: () => setState(() => _currentStep = 1),
                      child: const Text("Continue", style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  )
                ] else if (_currentStep == 1) ...[
                  const Text("Your Diet Preferences", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  const Text("Select all that apply", style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 20),
                  buildDietChips(),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _customDietController,
                          decoration: const InputDecoration(hintText: 'Add custom diet'),
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
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 14)),
                      onPressed: () => setState(() => _currentStep = 2),
                      child: const Text("Continue", style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                  TextButton(
                    onPressed: () => setState(() => _currentStep = 2),
                    child: const Text("Skip", style: TextStyle(color: Colors.green)),
                  )
                ] else if (_currentStep == 2) ...[
                  const Text("Any food allergies?", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  const Text("Select all that apply to you", style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 20),
                  buildAllergyChips(),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _customAllergyController,
                          decoration: const InputDecoration(hintText: 'Add custom allergy'),
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
                    child: const Text("None", style: TextStyle(color: Colors.green)),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 14)),
                      onPressed: _submitData,
                      child: const Text("Complete Set up", style: TextStyle(color: Colors.white, fontSize: 16)),
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
