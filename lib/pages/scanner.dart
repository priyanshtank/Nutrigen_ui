import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

//widget structure
class BarcodeScannerPage extends StatefulWidget { //Uses a StatefulWidget because barcodeValue updates dynamically when a new barcode is scanned.
  const BarcodeScannerPage({super.key});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  String? barcodeValue; //Stores the scanned barcode value
  final MobileScannerController controller = MobileScannerController(); //Allows control of camera

  @override
  Widget build(BuildContext context) { //Builds the UI of the scanner page
    // Scaffold provides the basic material design visual layout structure
    // AppBar is the top bar of the page with a title and close button
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
            onDetect: (barcodeCapture) { //Triggers when a barcode is detected
              final barcode = barcodeCapture.barcodes.first; // Gets the first detected barcode
              // Checks if the barcode has a raw value and if it is different from the current barcode
              final code = barcode.rawValue; //Extracts the actual string value encoded in the barcode.

              if (code != null && code != barcodeValue) { //Prevents duplicate state updates and multiple renders for the same barcode
                setState(() => barcodeValue = code); 
                debugPrint('📦 Barcode found: $code');
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
