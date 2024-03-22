
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(
          color: Colors.white

        ),
        title: const Text('QR/Barcode Scanner', style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(height: 100,),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('Scan Heartyculture Nursery Plant QR/Barcode ' , style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
            ),
            const SizedBox(height: 30,),


            Container(
              height: 300,
              child: MobileScanner(
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
            ),
          ],
        ),
      ),
    );
  }
}
