import 'package:flutter/material.dart';
import 'package:hcn_flutter/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heartyculture Nursery',
      theme: ThemeData(
        primaryColor: const Color(0xff378564),
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
       // useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
