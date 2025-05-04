import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:habit_hub/screens/webview.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanea el QR'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/generate");
            },
            icon: const Icon(
              Icons.qr_code,
            )
          )
        ]
      ),
      body: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
          returnImage: false,
        ),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;

          for (final barcode in barcodes) {
            final String? rawValue = barcode.rawValue;

            if (rawValue != null) {
              if (rawValue.startsWith('http')) {
                if (rawValue.endsWith('.png') ||
                    rawValue.endsWith('.jpg') ||
                    rawValue.endsWith('.jpeg') ||
                    rawValue.endsWith('.webp')) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Imagen desde QR'),
                      content: Image.network(rawValue),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cerrar'),
                        ),
                      ],
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebViewScreen(url: rawValue),
                    ),
                  );
                }
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Código QR detectado'),
                    content: Text(rawValue),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cerrar'),
                      ),
                    ],
                  ),
                );
              }
              break;
            }
          }
        },
      ),
    );
  }
}