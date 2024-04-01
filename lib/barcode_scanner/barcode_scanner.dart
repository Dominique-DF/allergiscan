import 'package:allergi_scan/scan_result/button_return.dart';
import 'package:allergi_scan/scan_result/scan_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zxing/flutter_zxing.dart';

class BarcodeScanner extends StatefulWidget {
  const BarcodeScanner({super.key});

  @override
  State<BarcodeScanner> createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ReaderWidget(
        onScan: (result) async {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ScanResult(barcode: result.text ?? 'erreur')));
        },
      ),
      const Align(
        alignment: Alignment.bottomCenter,
        child: ButtonReturn(),
      ),
    ]);
  }
}
