// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'dashboard.dart'; // Or use OnboardingScreen if needed
// import 'onboarding.dart'; // Import your onboarding screen if applicable

// class OTPVerificationPage extends StatefulWidget {
//   // final String verificationId;

//   // const OTPVerificationPage({super.key, required this.verificationId});
//   final String verificationId; // The verification ID received from Firebase after sending the OTP
//   final String phone; // The phone number to which the OTP was sent

// const OTPVerificationPage({ // Pass the verification ID and phone number to the OTP verification page
//   super.key,
//   required this.verificationId,
//   required this.phone,
// });


//   @override
//   State<OTPVerificationPage> createState() => _OTPVerificationPageState();
// }

// class _OTPVerificationPageState extends State<OTPVerificationPage> {
//   final TextEditingController _otpController = TextEditingController(); // retrieves text input from the user.
//   bool _isLoading = false;
//   String? _errorMessage;

//   Future<void> _verifyOTP() async { // Function to verify the OTP entered by the user
//     final otp = _otpController.text.trim(); // Retrieves the OTP entered by the user and removes any leading or trailing whitespac
//     if (otp.length != 6) { // Checks if the OTP is exactly 6 digits long
//       setState(() {
//         _errorMessage = "Enter a valid 6-digit OTP";
//       });
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     try {
//       final credential = PhoneAuthProvider.credential( //Creates a PhoneAuthCredential using:
//         verificationId: widget.verificationId, // The verification ID received from Firebase after sending the OTP
//         smsCode: otp,// The OTP entered by the user
//       );

//       await FirebaseAuth.instance.signInWithCredential(credential); //tries to sign in the user with the provided credential

//       // 🔐 If successful, navigate to dashboard or onboarding
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (_) => OnboardingScreen()),
//         (route) => false,
//       );
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         _errorMessage = "Invalid OTP. Please try again.";
//       });
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Something went wrong.";
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F9F9),
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(24),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   "Enter OTP",
//                   style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 24),

//                 TextField(
//                   controller: _otpController,
//                   keyboardType: TextInputType.number,
//                   maxLength: 6,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.lock),
//                     hintText: '6-digit OTP',
//                     filled: true,
//                     fillColor: Colors.white,
//                     counterText: '',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),

//                 if (_errorMessage != null)
//                   Text(
//                     _errorMessage!,
//                     style: const TextStyle(color: Colors.red),
//                   ),

//                 const SizedBox(height: 16),

//                 SizedBox(
//                   width: double.infinity,
//                   height: 52,
//                   child: ElevatedButton(
//                     onPressed: _isLoading ? null : _verifyOTP,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF4CAF50),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: _isLoading
//                         ? const CircularProgressIndicator(
//                             color: Colors.white,
//                             strokeWidth: 2,
//                           )
//                         : const Text(
//                             'Verify OTP',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'onboarding.dart';

class OTPVerificationPage extends StatefulWidget {
  final String verificationId;
  final String phone;
  final VoidCallback? onSuccess; // 👈 Callback for post-verification

  const OTPVerificationPage({
    super.key,
    required this.verificationId,
    required this.phone,
    this.onSuccess,
  });

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _verifyOTP() async {
    final otp = _otpController.text.trim();
    if (otp.length != 6) {
      setState(() {
        _errorMessage = "Enter a valid 6-digit OTP";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      // 🔄 Dynamic navigation logic
      if (widget.onSuccess != null) {
        widget.onSuccess!();
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const OnboardingScreen()),
          (route) => false,
        );
      }
    } on FirebaseAuthException {
      setState(() {
        _errorMessage = "Invalid OTP. Please try again.";
      });
    } catch (_) {
      setState(() {
        _errorMessage = "Something went wrong.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Enter OTP",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),

                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: '6-digit OTP',
                    filled: true,
                    fillColor: Colors.white,
                    counterText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _verifyOTP,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          )
                        : const Text(
                            'Verify OTP',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
