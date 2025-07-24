// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';

// //widget structure
// class BarcodeScannerPage extends StatefulWidget {
//   //Uses a StatefulWidget because barcodeValue updates dynamically when a new barcode is scanned.
//   const BarcodeScannerPage({super.key});

//   @override
//   State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
// }

// class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
//   String? barcodeValue; //Stores the scanned barcode value
//   final MobileScannerController controller =
//       MobileScannerController(); //Allows control of camera

//   @override
//   Widget build(BuildContext context) {
//     //Builds the UI of the scanner page
//     // Scaffold provides the basic material design visual layout structure
//     // AppBar is the top bar of the page with a title and close button
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Scan Item'),
//         leading: IconButton(
//           icon: const Icon(Icons.close),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Stack(
//         children: [
//           MobileScanner(
//             controller: controller,
//             onDetect: (barcodeCapture) {
//               //Triggers when a barcode is detected
//               final barcode = barcodeCapture
//                   .barcodes.first; // Gets the first detected barcode
//               // Checks if the barcode has a raw value and if it is different from the current barcode
//               final code = barcode
//                   .rawValue; //Extracts the actual string value encoded in the barcode.

//               if (code != null && code != barcodeValue) {
//                 //Prevents duplicate state updates and multiple renders for the same barcode
//                 setState(() => barcodeValue = code);
//                 debugPrint('📦 Barcode found: $code');
//               }
//             },
//           ),
//           if (barcodeValue != null)
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 margin: const EdgeInsets.all(20),
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.green.shade700.withOpacity(0.9),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(
//                   'Scanned Barcode: $barcodeValue',
//                   style: const TextStyle(
//                     fontSize: 18,
//                     color: Colors.white,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// properly formatted code snippet for the barcode scanner page working

// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'barcode_success_page.dart';

// class BarcodeScannerPage extends StatefulWidget {
//   const BarcodeScannerPage({super.key});

//   @override
//   State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
// }

// class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
//   String? barcodeValue;
//   final MobileScannerController controller = MobileScannerController();
//   bool isProcessing = false;
//   final String userId = "user_001";

//   Future<void> fetchProductDetails(String barcode) async {
//     const String apiUrl =
//         'https://product-info-api-546561582790.asia-south1.run.app/api/v1/product';

//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'barcode': barcode, 'user_id': userId}),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => BarcodeSuccessPage(productData: data),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Product not found or error occurred.')),
//         );
//         setState(() => isProcessing = false);
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//       setState(() => isProcessing = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Barcode scanner camera view
//           MobileScanner(
//             controller: controller,
//             fit: BoxFit.cover,
//             onDetect: (barcodeCapture) {
//               final code = barcodeCapture.barcodes.first.rawValue;

//               if (code != null && code != barcodeValue && !isProcessing) {
//                 setState(() {
//                   barcodeValue = code;
//                   isProcessing = true;
//                 });
//                 fetchProductDetails(code);
//               }
//             },
//           ),

//           // Dark transparent overlay
//           Container(color: Colors.black.withOpacity(0.4)),

//           // Scanner focus box
//           Align(
//             alignment: Alignment.center,
//             child: Container(
//               width: 250,
//               height: 250,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.white, width: 2),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//             ),
//           ),

//           // Top bar with back button
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: Colors.black54,
//                     child: IconButton(
//                       icon: const Icon(Icons.close, color: Colors.white),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   const Text(
//                     'Scan Item',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),

//           // Display scanned barcode value
//           if (barcodeValue != null)
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 margin: const EdgeInsets.only(bottom: 30),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
//                 decoration: BoxDecoration(
//                   color: Colors.green.shade600.withOpacity(0.95),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(
//                   'Scanned: $barcodeValue',
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),

//           // Loading overlay
//           if (isProcessing)
//             Container(
//               color: Colors.black.withOpacity(0.6),
//               child: const Center(
//                 child: CircularProgressIndicator(color: Colors.white),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// // for testing purpose
// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'print_result_page.dart';
// import 'services/auth_service.dart';

// class BarcodeScannerPage extends StatefulWidget {
//   const BarcodeScannerPage({super.key});

//   @override
//   State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
// }

// class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
//   String? barcodeValue;
//   final MobileScannerController controller = MobileScannerController();
//   bool isProcessing = false;
//   final String userId = "user_001";

//   @override
//   void initState() {
//     super.initState();
//     AuthService
//         .signInIfNeeded(); // Sign in anonymously if not signed in already
//   }

//   Future<void> fetchProductDetails(String barcode) async {
//     final String apiUrl =
//         'https://8x2qj4qs-8000.inc1.devtunnels.ms/api/barcode';

//     final token = await AuthService.getToken();
//     if (token == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Error: Could not get auth token")),
//       );
//       setState(() => isProcessing = false);
//       return;
//     }

//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode({'barcode': barcode, 'user_id': userId}),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PrintResultPage(productData: data),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Product not found or error occurred.')),
//         );
//         setState(() => isProcessing = false);
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//       setState(() => isProcessing = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           MobileScanner(
//             controller: controller,
//             fit: BoxFit.cover,
//             onDetect: (barcodeCapture) {
//               final code = barcodeCapture.barcodes.first.rawValue;

//               if (code != null && code != barcodeValue && !isProcessing) {
//                 setState(() {
//                   barcodeValue = code;
//                   isProcessing = true;
//                 });
//                 fetchProductDetails(code);
//               }
//             },
//           ),
//           Container(color: Colors.black.withOpacity(0.4)),
//           Align(
//             alignment: Alignment.center,
//             child: Container(
//               width: 250,
//               height: 250,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.white, width: 2),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//             ),
//           ),
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: Colors.black54,
//                     child: IconButton(
//                       icon: const Icon(Icons.close, color: Colors.white),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   const Text(
//                     'Scan Item',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           if (barcodeValue != null)
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 margin: const EdgeInsets.only(bottom: 30),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
//                 decoration: BoxDecoration(
//                   color: Colors.green.shade600.withOpacity(0.95),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(
//                   'Scanned: $barcodeValue',
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           if (isProcessing)
//             Container(
//               color: Colors.black.withOpacity(0.6),
//               child: const Center(
//                 child: CircularProgressIndicator(color: Colors.white),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'print_result_page.dart';
import 'services/auth_service.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  String? barcodeValue;
  final MobileScannerController controller = MobileScannerController();
  bool isProcessing = false;
  final String userId = "user_001";

  @override
  void initState() {
    super.initState();
    AuthService
        .signInIfNeeded(); // Sign in anonymously if not signed in already
  }

  Future<void> fetchProductDetails(String barcode) async {
    final String apiUrl =
        'https://nutrigen-546561582790.asia-south1.run.app/api/barcode';

    final token = await AuthService.getToken();
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error: Could not get auth token")),
      );
      setState(() => isProcessing = false);
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'barcode': barcode, 'user_id': userId}),
      );

      // 🔍 Log API response to terminal
      print("🔵 API Status Code: ${response.statusCode}");
      print("📦 Raw API Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print("✅ Decoded API Response:");
        const JsonEncoder encoder = JsonEncoder.withIndent('  ');
        print(encoder.convert(data));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PrintResultPage(productData: data),
          ),
        );
      } else {
        print("❌ Error: Status Code ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product not found or error occurred.')),
        );
        setState(() => isProcessing = false);
      }
    } catch (e) {
      print("🔥 Exception occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      setState(() => isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            fit: BoxFit.cover,
            onDetect: (barcodeCapture) {
              final code = barcodeCapture.barcodes.first.rawValue;

              if (code != null && code != barcodeValue && !isProcessing) {
                setState(() {
                  barcodeValue = code;
                  isProcessing = true;
                });
                fetchProductDetails(code);
              }
            },
          ),
          Container(color: Colors.black.withOpacity(0.4)),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Scan Item',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
          if (barcodeValue != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 30),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.green.shade600.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Scanned: $barcodeValue',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          if (isProcessing)
            Container(
              color: Colors.black.withOpacity(0.6),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
