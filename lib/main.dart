import 'package:flutter/material.dart';
import 'package:taskati/core/styles/themes.dart';
import 'package:taskati/features/splash/splash_screen.dart';

void main() {
  runApp(const Taskati());
}

class Taskati extends StatelessWidget {
  const Taskati({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.light,

      home: const SplashScreen(),
    );
  }
}
