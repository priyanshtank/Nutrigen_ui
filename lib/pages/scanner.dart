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

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'barcode_success_page.dart';

import 'barcode_success_page.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  String? barcodeValue;
  final MobileScannerController controller = MobileScannerController();
  bool isProcessing = false;
  final String userId = "user_1234";

  Future<void> fetchProductDetails(String barcode) async {
    const String apiUrl =
        'https://product-info-api-546561582790.asia-south1.run.app/api/v1/product';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'barcode': barcode, 'user_id': userId}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BarcodeSuccessPage(productData: data),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product not found or error occurred.')),
        );
        setState(() => isProcessing = false);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      setState(() => isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Item'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
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
          if (barcodeValue != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade700.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Scanned Barcode: $barcodeValue',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
