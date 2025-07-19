// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'onboarding.dart'; // Navigate here after signup

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   bool _isLoading = false;
//   String? _errorMessage;

//   Future<void> signUp() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     try {
//       final UserCredential userCredential =
//           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );

//       final token = await userCredential.user?.getIdToken();
//       final email = userCredential.user?.email;

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

  bool get isNumeric =>
      RegExp(r'^[0-9]+$').hasMatch(inputController.text.trim());
  bool get isEmail => RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$')
      .hasMatch(inputController.text.trim());

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

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
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
                    const Text("Sign Up",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    if (!isNumeric)
                      TextFormField(
                        controller: inputController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          hintText: 'Email or Mobile Number',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Enter email or phone' : null,
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
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            validator: (value) =>
                                value!.length < 6 ? 'Min 6 characters' : null,
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
                                isNumeric
                                    ? _handlePhoneVerification()
                                    : _handleEmailSignUp();
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
