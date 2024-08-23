import 'package:flutter/material.dart';
import 'package:ampiy_ui/views/splash_screen.dart'; // Ensure this path is correct

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true, // If you want to use Material 3 design
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // Ensure SplashScreen is a valid widget
    );
  }
}
