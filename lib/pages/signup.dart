// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'onboarding.dart'; // Navigate here after signup

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> { // This class manages the sign-up process
//   final _formKey = GlobalKey<FormState>(); //GlobalKey<FormState> lets you validate the form.
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController(); //Controllers fetch the values typed into the email & password fields.

//   bool _isLoading = false;
//   String? _errorMessage;

//   Future<void> signUp() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     try {
//       final UserCredential userCredential =
//           await FirebaseAuth.instance.createUserWithEmailAndPassword( //Calls Firebase to create the user.
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );

//       final token = await userCredential.user?.getIdToken(); // Retrieves the Firebase authentication token for the user
//       final email = userCredential.user?.email; // Gets the email of the newly created user

//       print("✅ Token: $token");
//       print("📧 Email: $email");

//       // Navigate to onboarding screen
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const OnboardingScreen()),
//       );
//     } on FirebaseAuthException catch (e) {
//       String message = "Something went wrong.";
//       if (e.code == 'weak-password') {
//         message = 'Password is too weak.';
//       } else if (e.code == 'email-already-in-use') {
//         message = 'Email is already in use.';
//       } else if (e.code == 'invalid-email') {
//         message = 'Invalid email address.';
//       }

//       setState(() => _errorMessage = message);
//     } catch (e) {
//       setState(() => _errorMessage = 'Unexpected error occurred.');
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(24),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   const Text(
//                     "Sign Up",
//                     style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 24),

//                   // Email Field
//                   TextFormField(
//                     controller: emailController,
//                     decoration: InputDecoration(
//                       prefixIcon: const Icon(Icons.email),
//                       hintText: 'Email',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     keyboardType: TextInputType.emailAddress,
//                     validator: (value) =>
//                         value!.isEmpty ? 'Enter your email' : null,
//                   ),
//                   const SizedBox(height: 16),

//                   // Password Field
//                   TextFormField(
//                     controller: passwordController,
//                     decoration: InputDecoration(
//                       prefixIcon: const Icon(Icons.lock),
//                       hintText: 'Password',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     obscureText: true,
//                     validator: (value) =>
//                         value!.length < 6 ? 'Minimum 6 characters' : null,
//                   ),
//                   const SizedBox(height: 16),

//                   // Error Message
//                   if (_errorMessage != null)
//                     Text(
//                       _errorMessage!,
//                       style: const TextStyle(color: Colors.red),
//                     ),

//                   const SizedBox(height: 16),

//                   // Signup Button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                       ),
//                       onPressed: _isLoading
//                           ? null
//                           : () {
//                               if (_formKey.currentState!.validate()) {
//                                 signUp();
//                               }
//                             },
//                       child: _isLoading
//                           ? const CircularProgressIndicator(
//                               color: Colors.white,
//                               strokeWidth: 2,
//                             )
//                           : const Text(
//                               "Sign Up",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


//version1-invlaid auth email/mobile number
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:nutrigen_ui/pages/otp_verification.dart';
// import 'onboarding.dart';

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController inputController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   bool _isLoading = false;
//   String? _errorMessage;

//   bool isNumeric(String value) => RegExp(r'^[0-9]{10}\$').hasMatch(value);
//   bool isEmail(String value) => RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,4}\$').hasMatch(value);

//   void _handleSignUp() async {
//     final input = inputController.text.trim();
//     final password = passwordController.text.trim();

//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     try {
//       if (isNumeric(input)) {
//         // Phone sign up via OTP
//         await FirebaseAuth.instance.verifyPhoneNumber(
//           phoneNumber: "+91$input",
//           verificationCompleted: (PhoneAuthCredential credential) async {
//             await FirebaseAuth.instance.signInWithCredential(credential);
//             Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
//           },
//           verificationFailed: (FirebaseAuthException e) {
//             setState(() => _errorMessage = e.message);
//           },
//           codeSent: (verificationId, resendToken) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => OTPVerificationPage(
//                   phone: input,
//                   verificationId: verificationId,
//                 ),
//               ),
//             );
//           },
//           codeAutoRetrievalTimeout: (verificationId) {},
//         );
//       } else if (isEmail(input)) {
//         final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: input,
//           password: password,
//         );

//         final token = await userCredential.user?.getIdToken();
//         print("✅ Email: ${userCredential.user?.email}");
//         print("🔐 Token: $token");

//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
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
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
//     } catch (e) {
//       print("❌ Google Sign-In Failed: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 const Text("Sign Up", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 24),

//                 TextFormField(
//                   controller: inputController,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.alternate_email),
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
//                   onPressed: _isLoading ? null : () {
//                     if (_formKey.currentState!.validate()) _handleSignUp();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     minimumSize: const Size(double.infinity, 48),
//                   ),
//                   child: _isLoading
//                       ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
//                       : const Text("Sign Up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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


//without country code
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'otp_verification.dart';
// import 'onboarding.dart';

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController inputController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   bool _isLoading = false;
//   String? _errorMessage;

//   bool get isNumeric => RegExp(r'^[0-9]{10}$').hasMatch(inputController.text.trim());
//   bool get isEmail => RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$').hasMatch(inputController.text.trim());

//   @override
//   void initState() {
//     super.initState();
//     inputController.addListener(() => setState(() {})); // to rerender UI
//   }

//   Future<void> _handleSignUp() async {
//     final input = inputController.text.trim();
//     final password = passwordController.text.trim();

//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     try {
//       if (isNumeric) {
//         await FirebaseAuth.instance.verifyPhoneNumber( //Calls Firebase to start verifying the phone number.
//           phoneNumber: "+91$input",
//           verificationCompleted: (PhoneAuthCredential credential) async { // Automatically signs in the user if the verification is completed successfully
//             await FirebaseAuth.instance.signInWithCredential(credential); //A PhoneAuthCredential is generated and used to sign in the user
//             Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen())); // If auto-verification happens (e.g., OTP auto-detected), sign in directly and go to onboarding.
//           },
//           verificationFailed: (FirebaseAuthException e) {
//             setState(() => _errorMessage = e.message);
//           },
//           codeSent: (verificationId, resendToken) { // If OTP is sent, navigate to OTP verification page with the verification ID and phone number
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => OTPVerificationPage(
//                   phone: input,
//                   verificationId: verificationId,
//                 ),
//               ),
//             );
//           },
//           codeAutoRetrievalTimeout: (verificationId) {},
//         );
//       } else if (isEmail) {
//         final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword( //if input is a valid email, create a new user with email and password
//           email: input,
//           password: password,
//         );

//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
//       } else {
//         setState(() => _errorMessage = 'Invalid input. Enter a valid email or 10-digit phone number.');
//       }
//     } on FirebaseAuthException catch (e) {
//       setState(() => _errorMessage = e.message);
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   Future<void> _handleGoogleSignUp() async {
//     try {
//       await GoogleSignIn().signOut(); // 👈 allow account switching
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
//     final showPassword = isEmail;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 const Text("Sign Up", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 24),

//                 TextFormField(
//                   controller: inputController,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.alternate_email),
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
//                   onPressed: _isLoading ? null : () {
//                     if (_formKey.currentState!.validate()) _handleSignUp();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     minimumSize: const Size(double.infinity, 48),
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                   ),
//                   child: _isLoading
//                       ? const CircularProgressIndicator(color: Colors.white)
//                       : const Text("Sign Up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                 ),

//                 const SizedBox(height: 20),

//                 TextButton.icon(
//                   onPressed: _handleGoogleSignUp,
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
// import 'onboarding.dart';

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
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
//     inputController.addListener(() => setState(() {}));
//   }

//   Future<void> _handlePhoneVerification() async {
//     final phone = phoneController.text.trim();
//     final fullPhone = '$_countryCode$phone';

//     try {
//       await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: fullPhone,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           await FirebaseAuth.instance.signInWithCredential(credential);
//           Navigator.pushReplacement(
//               context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           setState(() => _errorMessage = e.message);
//         },
//         codeSent: (verificationId, resendToken) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => OTPVerificationPage(
//                 phone: phone,
//                 verificationId: verificationId,
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

//   Future<void> _handleEmailSignUp() async {
//     final email = inputController.text.trim();
//     final password = passwordController.text.trim();

//     try {
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
//     } on FirebaseAuthException catch (e) {
//       setState(() => _errorMessage = e.message);
//     }
//   }

//   Future<void> _handleGoogleSignUp() async {
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
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
//     } catch (e) {
//       setState(() => _errorMessage = "Google sign-in failed. Try again.");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final input = inputController.text.trim();

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 const Text("Sign Up", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 24),

//                 if (!isNumeric)
//                   TextFormField(
//                     controller: inputController,
//                     decoration: InputDecoration(
//                       prefixIcon: const Icon(Icons.person),
//                       hintText: 'Email or Mobile Number',
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                     ),
//                     validator: (value) => value!.isEmpty ? 'Enter email or phone' : null,
//                   ),

//                 if (isNumeric)
//                   IntlPhoneField(
//                     initialCountryCode: 'IN',
//                     decoration: const InputDecoration(
//                       labelText: 'Phone Number',
//                       border: OutlineInputBorder(),
//                     ),
//                     onChanged: (phone) {
//                       _countryCode = phone.countryCode;
//                       phoneController.text = phone.number;
//                     },
//                   ),

//                 const SizedBox(height: 16),

//                 if (isEmail)
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
//                             isNumeric ? _handlePhoneVerification() : _handleEmailSignUp();
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
//                       : Text(isNumeric ? "Send OTP" : "Sign Up",
//                           style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                 ),

//                 const SizedBox(height: 20),

//                 TextButton.icon(
//                   onPressed: _handleGoogleSignUp,
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


//perfect version fri evening demo
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'otp_verification.dart';
// import 'onboarding.dart';

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
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
//     inputController.addListener(() => setState(() {}));
//   }

//   Future<void> _handlePhoneVerification() async {
//     final phone = phoneController.text.trim();
//     final fullPhone = '$_countryCode$phone';

//     try {
//       await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: fullPhone,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           await FirebaseAuth.instance.signInWithCredential(credential);
//           Navigator.pushReplacement(
//               context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           setState(() => _errorMessage = e.message);
//         },
//         codeSent: (verificationId, resendToken) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => OTPVerificationPage(
//                 phone: phone,
//                 verificationId: verificationId,
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

//   Future<void> _handleEmailSignUp() async {
//     final email = inputController.text.trim();
//     final password = passwordController.text.trim();

//     try {
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
//     } on FirebaseAuthException catch (e) {
//       setState(() => _errorMessage = e.message);
//     }
//   }

//   Future<void> _handleGoogleSignUp() async {
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
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
//     } catch (e) {
//       setState(() => _errorMessage = "Google sign-in failed. Try again.");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final input = inputController.text.trim();

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(24),
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(maxWidth: 400),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Text("Sign Up", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
//                     const SizedBox(height: 24),

//                     if (!isNumeric)
//                       TextFormField(
//                         controller: inputController,
//                         decoration: InputDecoration(
//                           prefixIcon: const Icon(Icons.person),
//                           hintText: 'Email or Mobile Number',
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                         ),
//                         validator: (value) => value!.isEmpty ? 'Enter email or phone' : null,
//                       ),

//                     if (isNumeric)
//                       IntlPhoneField(
//                         initialCountryCode: 'IN',
//                         decoration: const InputDecoration(
//                           labelText: 'Phone Number',
//                           border: OutlineInputBorder(),
//                         ),
//                         onChanged: (phone) {
//                           _countryCode = phone.countryCode;
//                           phoneController.text = phone.number;
//                         },
//                       ),

//                     const SizedBox(height: 16),

//                     if (isEmail)
//                       TextFormField(
//                         controller: passwordController,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           prefixIcon: const Icon(Icons.lock),
//                           hintText: 'Password',
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                         ),
//                         validator: (value) => value!.length < 6 ? 'Min 6 characters' : null,
//                       ),

//                     const SizedBox(height: 16),

//                     if (_errorMessage != null)
//                       Text(_errorMessage!, style: const TextStyle(color: Colors.red)),

//                     const SizedBox(height: 16),

//                     ElevatedButton(
//                       onPressed: _isLoading
//                           ? null
//                           : () {
//                               if (_formKey.currentState!.validate()) {
//                                 setState(() => _isLoading = true);
//                                 isNumeric ? _handlePhoneVerification() : _handleEmailSignUp();
//                                 setState(() => _isLoading = false);
//                               }
//                             },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         minimumSize: const Size(double.infinity, 48),
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                       ),
//                       child: _isLoading
//                           ? const CircularProgressIndicator(color: Colors.white)
//                           : Text(
//                               isNumeric ? "Send OTP" : "Sign Up",
//                               style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                             ),
//                     ),

//                     const SizedBox(height: 20),

//                     TextButton.icon(
//                       onPressed: _handleGoogleSignUp,
//                       icon: const Icon(Icons.g_mobiledata, color: Colors.red),
//                       label: const Text("Continue with Google", style: TextStyle(fontSize: 16)),
//                     ),
//                   ],
//                 ),
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

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController inputController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final storage = const FlutterSecureStorage();

  bool _rememberMe = false;
  bool _isLoading = false;
  String? _errorMessage;
  String _countryCode = '+91';

  bool get isNumeric => RegExp(r'^[0-9]+$').hasMatch(inputController.text.trim());
  bool get isEmail => RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$').hasMatch(inputController.text.trim());

  @override
  void initState() {
    super.initState();
    inputController.addListener(() => setState(() {}));
  }

  Future<void> _handleEmailSignUp() async {
    final email = inputController.text.trim();
    final password = passwordController.text.trim();

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (_rememberMe) {
        await storage.write(key: 'saved_email', value: email);
        await storage.write(key: 'saved_password', value: password);
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() => _errorMessage = e.message);
    }
  }

  Future<void> _handlePhoneVerification() async {
    final phone = phoneController.text.trim();
    final fullPhone = '$_countryCode$phone';

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: fullPhone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const OnboardingScreen()),
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() => _errorMessage = e.message);
        },
        codeSent: (verificationId, resendToken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OTPVerificationPage(
                phone: phone,
                verificationId: verificationId,
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

  Future<void> _handleGoogleSignUp() async {
    try {
      await GoogleSignIn().signOut(); // Reset any previous session
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    } catch (e) {
      setState(() => _errorMessage = "Google sign-in failed. Try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final input = inputController.text.trim();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Sign Up", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),

                    if (!isNumeric)
                      TextFormField(
                        controller: inputController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          hintText: 'Email or Mobile Number',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        validator: (value) => value!.isEmpty ? 'Enter email or phone' : null,
                      ),

                    if (isNumeric)
                      IntlPhoneField(
                        initialCountryCode: 'IN',
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
                      Column(
                        children: [
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
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (value) {
                                  setState(() => _rememberMe = value!);
                                },
                              ),
                              const Text("Remember Me"),
                            ],
                          ),
                        ],
                      ),

                    const SizedBox(height: 16),

                    if (_errorMessage != null)
                      Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),

                    const SizedBox(height: 16),

                    ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                setState(() => _isLoading = true);
                                isNumeric ? _handlePhoneVerification() : _handleEmailSignUp();
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
                              isNumeric ? "Send OTP" : "Sign Up",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),

                    const SizedBox(height: 20),

                    TextButton.icon(
                      onPressed: _handleGoogleSignUp,
                      icon: const Icon(Icons.g_mobiledata, color: Colors.red),
                      label: const Text(
                        "Continue with Google",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
