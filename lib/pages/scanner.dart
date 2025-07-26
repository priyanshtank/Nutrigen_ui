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
