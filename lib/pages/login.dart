
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'dashboard.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _auth = FirebaseAuth.instance; // creates an instance of the Firebase authentication that lets you perform actions like sign in, sign out, get user data, etc.
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController(); //These controllers store the email and password the user enters in the text fields.

//   String? _userEmail; // Stores the email of the logged-in user
//   String? _token; // Stores the Firebase authentication token for the user

//   Future<void> _loginUser() async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword( //attempts to log in the user with email and password using Firebase
//         email: _emailController.text.trim(), // Trims any whitespace from the email input
//         password: _passwordController.text.trim(), // Trims any whitespace from the password input
//       );

//       User? user = userCredential.user; // Gets the user object from the userCredential
//       if (user != null) {
//         String? token = await user.getIdToken(); // Retrieves the Firebase authentication token for the user

//         setState(() {
//           _userEmail = user.email;
//           _token = token;
//         });

//         print('✅ Email: ${user.email}');
//         print('🔐 Firebase Token: $token');

//         // Navigate to dashboard (you can pass the token/email if needed)
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => DashboardScreen()),
//         );
//       }
//     } catch (e) {
//       print("❌ Login Error: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Invalid credentials')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F9F9),
//       body: SafeArea(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'Login',
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 40),

//                   TextField(
//                     controller: _emailController,
//                     decoration: InputDecoration(
//                       prefixIcon: const Icon(Icons.person),
//                       hintText: 'Email',
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),

//                   TextField(
//                     controller: _passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       prefixIcon: const Icon(Icons.lock),
//                       hintText: 'Password',
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 24),

//                   SizedBox(
//                     width: double.infinity,
//                     height: 52,
//                     child: ElevatedButton(
//                       onPressed: _loginUser,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF4CAF50),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const Text(
//                         'Login',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 24),

//                   if (_userEmail != null && _token != null) ...[
//                     Text("📧 Email: $_userEmail"),
//                     const SizedBox(height: 12),
//                     SelectableText(
//                       "🔐 Token: $_token",
//                       style: const TextStyle(fontSize: 12),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


//version1- not validated email/number
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'otp_verification.dart';
// import 'dashboard.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController inputController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   bool _isLoading = false;
//   String? _errorMessage;

//   bool isNumeric(String value) => RegExp(r'^[0-9]{10}$').hasMatch(value);
//   bool isEmail(String value) => RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$').hasMatch(value);

//   Future<void> _handleLogin() async {
//     final input = inputController.text.trim();
//     final password = passwordController.text.trim();

//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     try {
//       if (isNumeric(input)) {
//         // 🔐 Phone login via OTP
//         await FirebaseAuth.instance.verifyPhoneNumber(
//           phoneNumber: "+91$input",
//           verificationCompleted: (PhoneAuthCredential credential) async {
//             await FirebaseAuth.instance.signInWithCredential(credential);
//             Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen()));
//           },
//           verificationFailed: (FirebaseAuthException e) {
//             setState(() => _errorMessage = e.message);
//           },
//           codeSent: (verificationId, resendToken) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => OTPVerificationPage(
//                   verificationId: verificationId,
//                   phone:input,
//                 ),
//               ),
//             );
//           },
//           codeAutoRetrievalTimeout: (verificationId) {},
//         );
//       } else if (isEmail(input)) {
//         final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: input,
//           password: password,
//         );

//         final token = await userCredential.user?.getIdToken();
//         print("✅ Email: ${userCredential.user?.email}");
//         print("🔐 Token: $token");

//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  DashboardScreen()));
//       } else {
//         setState(() => _errorMessage = 'Invalid input. Enter a valid email or 10-digit phone number.');
//       }
//     } on FirebaseAuthException catch (e) {
//       setState(() => _errorMessage = e.message);
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   Future<void> _handleGoogleSignIn() async {
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//       await FirebaseAuth.instance.signInWithCredential(credential);
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  DashboardScreen()));
//     } catch (e) {
//       print("❌ Google Sign-In Failed: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F9F9),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 const Text("Login", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 24),

//                 TextFormField(
//                   controller: inputController,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.person),
//                     hintText: 'Email or Mobile Number',
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                   ),
//                   validator: (value) => value!.isEmpty ? 'Enter email or mobile number' : null,
//                 ),
//                 const SizedBox(height: 16),

//                 TextFormField(
//                   controller: passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.lock),
//                     hintText: 'Password',
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                   ),
//                   validator: (value) => value!.length < 6 ? 'Minimum 6 characters' : null,
//                 ),
//                 const SizedBox(height: 16),

//                 if (_errorMessage != null)
//                   Text(_errorMessage!, style: const TextStyle(color: Colors.red)),

//                 const SizedBox(height: 16),

//                 ElevatedButton(
//                   onPressed: _isLoading
//                       ? null
//                       : () {
//                           if (_formKey.currentState!.validate()) {
//                             _handleLogin();
//                           }
//                         },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     minimumSize: const Size(double.infinity, 48),
//                   ),
//                   child: _isLoading
//                       ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
//                       : const Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                 ),

//                 const SizedBox(height: 20),

//                 TextButton.icon(
//                   onPressed: _handleGoogleSignIn,
//                   icon: const Icon(Icons.g_mobiledata, color: Colors.red),
//                   label: const Text("Continue with Google", style: TextStyle(fontSize: 16)),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'otp_verification.dart';
// import 'dashboard.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> { 
//   final _formKey = GlobalKey<FormState>(); // This key uniquely identifies the form and allows validation
//   final TextEditingController inputController = TextEditingController(); //captires email/phome no
//   final TextEditingController passwordController = TextEditingController(); //captures password
 
//   bool _isLoading = false;
//   String? _errorMessage;

//   bool get isNumeric => RegExp(r'^[0-9]{10}$').hasMatch(inputController.text.trim()); // checks if input is a 10-digit number
//   bool get isEmail => RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$').hasMatch(inputController.text.trim()); // checks if input is a valid email format

//   @override 
//   void initState() { //Rebuilds the widget every time the input changes — useful to toggle between showing password field or OTP info.
//     super.initState();
//     inputController.addListener(() => setState(() {})); // to trigger dynamic UI
//   }

//   Future<void> _handleLogin() async {
//     final input = inputController.text.trim(); // Get the trimmed input from the controller
//     final password = passwordController.text.trim(); // Get the trimmed password from the controller

//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     try {
//       if (isNumeric) {
//         // Phone login
//         await FirebaseAuth.instance.verifyPhoneNumber( //Calls Firebase to send OTP to a phone number.
//           phoneNumber: "+91$input",
//           verificationCompleted: (PhoneAuthCredential credential) async { // Automatically signs in the user if the verification is completed successfully
//             await FirebaseAuth.instance.signInWithCredential(credential);
//             Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen())); //If auto-verification happens (e.g., OTP auto-detected), sign in directly and go to dashboard.
//           },
//           verificationFailed: (FirebaseAuthException e) {
//             setState(() => _errorMessage = e.message); // If verification fails, show the error message
//           },
//           codeSent: (verificationId, resendToken) { // If OTP is sent, navigate to OTP verification page
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => OTPVerificationPage( // Pass the verification ID and phone number to the OTP verification page
//                   verificationId: verificationId,
//                   phone: input,
//                 ),
//               ),
//             );
//           },
//           codeAutoRetrievalTimeout: (verificationId) {},
//         );
//       } else if (isEmail) {
//         final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: input,
//           password: password,
//         );
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen()));
//       } else {
//         setState(() => _errorMessage = 'Invalid input. Enter valid email or 10-digit phone number.');
//       }
//     } on FirebaseAuthException catch (e) {
//       setState(() => _errorMessage = e.message);
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   Future<void> _handleGoogleSignIn() async {
//     try {
//       await GoogleSignIn().signOut(); // to allow re-login with different account
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn(); //Prompts user to choose a Google account.
//       if (googleUser == null) return;

//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication; // Retrieves the authentication details from the Google sign-in process
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       await FirebaseAuth.instance.signInWithCredential(credential);
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen()));
//     } catch (e) {
//       setState(() => _errorMessage = "Google sign-in failed. Try again.");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final showPassword = isEmail;

//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F9F9),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 const Text("Login", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 24),

//                 TextFormField(
//                   controller: inputController,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.person),
//                     hintText: 'Email or Mobile Number',
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                   ),
//                   validator: (value) => value!.isEmpty ? 'Enter email or phone' : null,
//                 ),
//                 const SizedBox(height: 16),

//                 if (showPassword)
//                   TextFormField(
//                     controller: passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       prefixIcon: const Icon(Icons.lock),
//                       hintText: 'Password',
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                     ),
//                     validator: (value) => value!.length < 6 ? 'Min 6 characters' : null,
//                   ),
//                 if (!showPassword)
//                   const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 8.0),
//                     child: Text('OTP will be sent to your number', style: TextStyle(color: Colors.grey)),
//                   ),

//                 const SizedBox(height: 16),

//                 if (_errorMessage != null)
//                   Text(_errorMessage!, style: const TextStyle(color: Colors.red)),

//                 const SizedBox(height: 16),

//                 ElevatedButton(
//                   onPressed: _isLoading
//                       ? null
//                       : () {
//                           if (_formKey.currentState!.validate()) {
//                             _handleLogin();
//                           }
//                         },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     minimumSize: const Size(double.infinity, 48),
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                   ),
//                   child: _isLoading
//                       ? const CircularProgressIndicator(color: Colors.white)
//                       : const Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                 ),
//                 const SizedBox(height: 20),

//                 TextButton.icon(
//                   onPressed: _handleGoogleSignIn,
//                   icon: const Icon(Icons.g_mobiledata, color: Colors.red),
//                   label: const Text("Continue with Google", style: TextStyle(fontSize: 16)),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'otp_verification.dart';
// import 'dashboard.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController inputController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();

//   bool _isLoading = false;
//   String? _errorMessage;
//   String _countryCode = '+91';
//   bool isPhoneInput = false;

//   @override
//   void initState() {
//     super.initState();
//     inputController.addListener(() {
//       final input = inputController.text.trim();
//       final isNumeric = RegExp(r'^[0-9]{1,10}\$').hasMatch(input);
//       final isEmail = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,4}\$').hasMatch(input);
//       setState(() {
//         isPhoneInput = isNumeric && !isEmail;
//       });
//     });
//   }

//   Future<void> _handlePhoneLogin() async {
//     final phone = phoneController.text.trim();
//     final fullPhone = '$_countryCode$phone';

//     try {
//       await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: fullPhone,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           await FirebaseAuth.instance.signInWithCredential(credential);
//           Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  DashboardScreen()));
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           setState(() => _errorMessage = e.message);
//         },
//         codeSent: (verificationId, resendToken) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => OTPVerificationPage(
//                 verificationId: verificationId,
//                 phone: phone,
//                 onSuccess: () => Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (_) => DashboardScreen()),
//                 ),
//               ),
//             ),
//           );
//         },
//         codeAutoRetrievalTimeout: (verificationId) {},
//       );
//     } on FirebaseAuthException catch (e) {
//       setState(() => _errorMessage = e.message);
//     }
//   }

//   Future<void> _handleEmailLogin() async {
//     final email = inputController.text.trim();
//     final password = passwordController.text.trim();

//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen()));
//     } on FirebaseAuthException catch (e) {
//       setState(() => _errorMessage = e.message);
//     }
//   }

//   Future<void> _handleGoogleSignIn() async {
//     try {
//       await GoogleSignIn().signOut();
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       if (googleUser == null) return;

//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       await FirebaseAuth.instance.signInWithCredential(credential);
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen()));
//     } catch (e) {
//       setState(() => _errorMessage = "Google sign-in failed. Try again.");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final input = inputController.text.trim();
//     final isEmail = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,4}\$').hasMatch(input);

//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F9F9),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 const Text("Login", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 24),

//                 if (!isPhoneInput)
//                   TextFormField(
//                     controller: inputController,
//                     decoration: InputDecoration(
//                       prefixIcon: const Icon(Icons.person),
//                       hintText: 'Email or Mobile Number',
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                     ),
//                     validator: (value) => value!.isEmpty ? 'Enter email or phone' : null,
//                   ),

//                 if (isEmail)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 16.0),
//                     child: TextFormField(
//                       controller: passwordController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.lock),
//                         hintText: 'Password',
//                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                       ),
//                       validator: (value) => value!.length < 6 ? 'Min 6 characters' : null,
//                     ),
//                   ),

//                 if (isPhoneInput)
//                   Column(
//                     children: [
//                       IntlPhoneField(
//                         initialCountryCode: 'IN',
//                         controller: phoneController,
//                         decoration: const InputDecoration(
//                           labelText: 'Phone Number',
//                           border: OutlineInputBorder(),
//                         ),
//                         onChanged: (phone) {
//                           _countryCode = phone.countryCode;
//                           phoneController.text = phone.number;
//                         },
//                       ),
//                     ],
//                   ),

//                 const SizedBox(height: 16),

//                 if (_errorMessage != null)
//                   Text(_errorMessage!, style: const TextStyle(color: Colors.red)),

//                 const SizedBox(height: 16),

//                 ElevatedButton(
//                   onPressed: _isLoading
//                       ? null
//                       : () {
//                           if (_formKey.currentState!.validate()) {
//                             setState(() => _isLoading = true);
//                             isPhoneInput ? _handlePhoneLogin() : _handleEmailLogin();
//                             setState(() => _isLoading = false);
//                           }
//                         },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     minimumSize: const Size(double.infinity, 48),
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                   ),
//                   child: _isLoading
//                       ? const CircularProgressIndicator(color: Colors.white)
//                       : Text(isPhoneInput ? "Send OTP" : "Login",
//                           style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                 ),

//                 const SizedBox(height: 20),

//                 TextButton.icon(
//                   onPressed: _handleGoogleSignIn,
//                   icon: const Icon(Icons.g_mobiledata, color: Colors.red),
//                   label: const Text("Continue with Google", style: TextStyle(fontSize: 16)),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//works but still shows the email/phone field even when phone input is detected
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'otp_verification.dart';
// import 'dashboard.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController inputController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();

//   bool _isLoading = false;
//   String? _errorMessage;
//   String _countryCode = '+91';
//   bool isPhoneInput = false;

//   @override
//   void initState() {
//     super.initState();
//     inputController.addListener(() {
//       final input = inputController.text.trim();
//       final isNumeric = RegExp(r'^[0-9]{1,10}$').hasMatch(input); // ✅ FIXED
//       final isEmail = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$').hasMatch(input); // ✅ FIXED
//       setState(() {
//         isPhoneInput = isNumeric && !isEmail;
//       });
//     });
//   }

//   Future<void> _handlePhoneLogin() async {
//     final phone = phoneController.text.trim();
//     final fullPhone = '$_countryCode$phone';

//     try {
//       await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: fullPhone,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           await FirebaseAuth.instance.signInWithCredential(credential);
//           Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  DashboardScreen()));
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           setState(() => _errorMessage = e.message);
//         },
//         codeSent: (verificationId, resendToken) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => OTPVerificationPage(
//                 verificationId: verificationId,
//                 phone: phone,
//                 onSuccess: () => Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (_) =>  DashboardScreen()),
//                 ),
//               ),
//             ),
//           );
//         },
//         codeAutoRetrievalTimeout: (verificationId) {},
//       );
//     } on FirebaseAuthException catch (e) {
//       setState(() => _errorMessage = e.message);
//     }
//   }

//   Future<void> _handleEmailLogin() async {
//     final email = inputController.text.trim();
//     final password = passwordController.text.trim();

//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  DashboardScreen()));
//     } on FirebaseAuthException catch (e) {
//       setState(() => _errorMessage = e.message);
//     }
//   }

//   Future<void> _handleGoogleSignIn() async {
//     try {
//       await GoogleSignIn().signOut();
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       if (googleUser == null) return;

//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       await FirebaseAuth.instance.signInWithCredential(credential);
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  DashboardScreen()));
//     } catch (e) {
//       setState(() => _errorMessage = "Google sign-in failed. Try again.");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final input = inputController.text.trim();
//     final isEmail = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$').hasMatch(input);

//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F9F9),
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(24),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Login", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 24),

//                   // Always show this field to allow input detection
//                   TextFormField(
//                     controller: inputController,
//                     decoration: InputDecoration(
//                       prefixIcon: const Icon(Icons.person),
//                       hintText: 'Email or Mobile Number',
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                     ),
//                     validator: (value) => value!.isEmpty ? 'Enter email or phone' : null,
//                   ),

//                   if (isEmail)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 16.0),
//                       child: TextFormField(
//                         controller: passwordController,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           prefixIcon: const Icon(Icons.lock),
//                           hintText: 'Password',
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                         ),
//                         validator: (value) => value!.length < 6 ? 'Min 6 characters' : null,
//                       ),
//                     ),

//                   if (isPhoneInput)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 16.0),
//                       child: IntlPhoneField(
//                         initialCountryCode: 'IN',
//                         controller: phoneController,
//                         decoration: const InputDecoration(
//                           labelText: 'Phone Number',
//                           border: OutlineInputBorder(),
//                         ),
//                         onChanged: (phone) {
//                           _countryCode = phone.countryCode;
//                           phoneController.text = phone.number;
//                         },
//                       ),
//                     ),

//                   const SizedBox(height: 16),

//                   if (_errorMessage != null)
//                     Text(_errorMessage!, style: const TextStyle(color: Colors.red)),

//                   const SizedBox(height: 16),

//                   ElevatedButton(
//                     onPressed: _isLoading
//                         ? null
//                         : () {
//                             if (_formKey.currentState!.validate()) {
//                               setState(() => _isLoading = true);
//                               isPhoneInput ? _handlePhoneLogin() : _handleEmailLogin();
//                               setState(() => _isLoading = false);
//                             }
//                           },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       minimumSize: const Size(double.infinity, 48),
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                     ),
//                     child: _isLoading
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : Text(
//                             isPhoneInput ? "Send OTP" : "Login",
//                             style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                           ),
//                   ),

//                   const SizedBox(height: 20),

//                   TextButton.icon(
//                     onPressed: _handleGoogleSignIn,
//                     icon: const Icon(Icons.g_mobiledata, color: Colors.red),
//                     label: const Text("Continue with Google", style: TextStyle(fontSize: 16)),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//perfect version fri evening demo
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'otp_verification.dart';
// import 'onboarding.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController inputController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();

//   bool _isLoading = false;
//   String? _errorMessage;
//   String _countryCode = '+91';

//   bool get isNumeric => RegExp(r'^[0-9]+$').hasMatch(inputController.text.trim());
//   bool get isEmail => RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$').hasMatch(inputController.text.trim());

//   @override
//   void initState() {
//     super.initState();
//     inputController.addListener(() {
//       setState(() {}); // Triggers rebuild on every input change
//     });
//   }

//   Future<void> _handlePhoneLogin() async {
//     final phone = phoneController.text.trim();
//     final fullPhone = '$_countryCode$phone';

//     try {
//       await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: fullPhone,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           await FirebaseAuth.instance.signInWithCredential(credential);
//           Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           setState(() => _errorMessage = e.message);
//         },
//         codeSent: (verificationId, resendToken) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => OTPVerificationPage(
//                 verificationId: verificationId,
//                 phone: phone,
//               ),
//             ),
//           );
//         },
//         codeAutoRetrievalTimeout: (verificationId) {},
//       );
//     } on FirebaseAuthException catch (e) {
//       setState(() => _errorMessage = e.message);
//     }
//   }

//   Future<void> _handleEmailLogin() async {
//     final email = inputController.text.trim();
//     final password = passwordController.text.trim();

//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
//     } on FirebaseAuthException catch (e) {
//       setState(() => _errorMessage = e.message);
//     }
//   }

//   Future<void> _handleGoogleSignIn() async {
//     try {
//       await GoogleSignIn().signOut();
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       if (googleUser == null) return;

//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       await FirebaseAuth.instance.signInWithCredential(credential);
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
//     } catch (e) {
//       setState(() => _errorMessage = "Google sign-in failed. Try again.");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final input = inputController.text.trim();
//     final isPhoneInput = isNumeric && !isEmail;

//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F9F9),
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(24),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Login", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 24),

//                   if (!isPhoneInput)
//                     TextFormField(
//                       controller: inputController,
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.person),
//                         hintText: 'Email or Mobile Number',
//                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                       ),
//                       validator: (value) => value!.isEmpty ? 'Enter email or phone' : null,
//                     ),

//                   if (isPhoneInput)
//                     IntlPhoneField(
//                       initialCountryCode: 'IN',
//                       controller: phoneController,
//                       decoration: const InputDecoration(
//                         labelText: 'Phone Number',
//                         border: OutlineInputBorder(),
//                       ),
//                       onChanged: (phone) {
//                         _countryCode = phone.countryCode;
//                         phoneController.text = phone.number;
//                       },
//                     ),

//                   const SizedBox(height: 16),

//                   if (isEmail)
//                     TextFormField(
//                       controller: passwordController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.lock),
//                         hintText: 'Password',
//                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                       ),
//                       validator: (value) => value!.length < 6 ? 'Min 6 characters' : null,
//                     ),

//                   const SizedBox(height: 16),

//                   if (_errorMessage != null)
//                     Text(_errorMessage!, style: const TextStyle(color: Colors.red)),

//                   const SizedBox(height: 16),

//                   ElevatedButton(
//                     onPressed: _isLoading
//                         ? null
//                         : () {
//                             if (_formKey.currentState!.validate()) {
//                               setState(() => _isLoading = true);
//                               isPhoneInput ? _handlePhoneLogin() : _handleEmailLogin();
//                               setState(() => _isLoading = false);
//                             }
//                           },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       minimumSize: const Size(double.infinity, 48),
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                     ),
//                     child: _isLoading
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : Text(isPhoneInput ? "Send OTP" : "Login",
//                             style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                   ),

//                   const SizedBox(height: 20),

//                   TextButton.icon(
//                     onPressed: _handleGoogleSignIn,
//                     icon: const Icon(Icons.g_mobiledata, color: Colors.red),
//                     label: const Text("Continue with Google", style: TextStyle(fontSize: 16)),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'otp_verification.dart';
import 'onboarding.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController inputController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  bool _isLoading = false;
  String? _errorMessage;
  String _countryCode = '+91';

  bool get isNumeric => RegExp(r'^[0-9]+$').hasMatch(inputController.text.trim());
  bool get isEmail => RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$').hasMatch(inputController.text.trim());

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
    inputController.addListener(() => setState(() {}));
  }

  Future<void> _loadSavedCredentials() async {
    final savedEmail = await storage.read(key: 'saved_email');
    final savedPassword = await storage.read(key: 'saved_password');

    if (savedEmail != null && savedPassword != null) {
      inputController.text = savedEmail;
      passwordController.text = savedPassword;
    }
  }

  Future<void> _clearSavedCredentials() async {
    await storage.delete(key: 'saved_email');
    await storage.delete(key: 'saved_password');
    inputController.clear();
    passwordController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Saved login cleared')),
    );
  }

  Future<void> _handlePhoneLogin() async {
    final phone = phoneController.text.trim();
    final fullPhone = '$_countryCode$phone';

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: fullPhone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() => _errorMessage = e.message);
        },
        codeSent: (verificationId, resendToken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OTPVerificationPage(
                verificationId: verificationId,
                phone: phone,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      setState(() => _errorMessage = e.message);
    }
  }

  Future<void> _handleEmailLogin() async {
    final email = inputController.text.trim();
    final password = passwordController.text.trim();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
    } on FirebaseAuthException catch (e) {
      setState(() => _errorMessage = e.message);
    }
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
    } catch (e) {
      setState(() => _errorMessage = "Google sign-in failed. Try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final input = inputController.text.trim();
    final isPhoneInput = isNumeric && !isEmail;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Login", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),

                  if (!isPhoneInput)
                    TextFormField(
                      controller: inputController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        hintText: 'Email or Mobile Number',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      validator: (value) => value!.isEmpty ? 'Enter email or phone' : null,
                    ),

                  if (isPhoneInput)
                    IntlPhoneField(
                      initialCountryCode: 'IN',
                      controller: phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (phone) {
                        _countryCode = phone.countryCode;
                        phoneController.text = phone.number;
                      },
                    ),

                  const SizedBox(height: 16),

                  if (isEmail)
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        hintText: 'Password',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      validator: (value) => value!.length < 6 ? 'Min 6 characters' : null,
                    ),

                  const SizedBox(height: 8),

                  if (isEmail)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _clearSavedCredentials,
                        child: const Text(
                          "Clear Saved Login",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),

                  const SizedBox(height: 8),

                  if (_errorMessage != null)
                    Text(_errorMessage!, style: const TextStyle(color: Colors.red)),

                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              setState(() => _isLoading = true);
                              isPhoneInput ? _handlePhoneLogin() : _handleEmailLogin();
                              setState(() => _isLoading = false);
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 48),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            isPhoneInput ? "Send OTP" : "Login",
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                  ),

                  const SizedBox(height: 20),

                  TextButton.icon(
                    onPressed: _handleGoogleSignIn,
                    icon: const Icon(Icons.g_mobiledata, color: Colors.red),
                    label: const Text("Continue with Google", style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
