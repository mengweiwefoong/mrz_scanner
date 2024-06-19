import 'package:flutter/material.dart';
import 'package:mrz_scanner/mrz_scanner.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MRZController controller = MRZController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (context) {
        return MRZScanner(
          controller: controller,
          showOverlay: true,
          onStart: () {
            print('MRZ Scanner Started');
          },
          onSuccess: (mrzResult, lines) async {
            await showDialog(
              context: context,
              builder: (context) => Dialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          controller.currentState?.resetScanning();
                        },
                        child: const Text('Reset Scanning'),
                      ),
                      Text('Sur Name : ${mrzResult.surnames}'),
                      Text('Given Name : ${mrzResult.givenNames}'),
                      Text('Gender : ${mrzResult.sex.name}'),
                      Text('CountryCode : ${mrzResult.countryCode}'),
                      Text('Date of Birth : ${mrzResult.birthDate}'),
                      Text('Expiry Date : ${mrzResult.expiryDate}'),
                      Text('DocNum : ${mrzResult.documentNumber}'),
                      Text('PersonalNo : ${mrzResult.personalNumber}'),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
