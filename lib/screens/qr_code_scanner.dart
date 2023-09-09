
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'plant_screen.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({super.key});

  @override
  State<QRCodeScanner> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MobileScanner(
        // fit: BoxFit.contain,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
           var plantId = barcodes[0].rawValue;
           if(plantId!=null){
             try {
               int number = int.parse(plantId);
               Navigator.pop(context);
               Navigator.of(context).push(MaterialPageRoute(builder:(context)=>PlantScreen(plantId: plantId)));
               print('Parsed successfully: $number');
             } catch (e) {
               print('Error: $e');
             }
           }
          }
      ),
    );
  }
}
