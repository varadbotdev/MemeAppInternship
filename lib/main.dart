import 'package:flutter/material.dart';
import 'package:meme/view/splashscree.dart';
import 'package:meme/view/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meme',
      home: const SplashScreen(),
    );
  }
}