import 'package:flutter/material.dart';
import 'package:taskati/core/styles/themes.dart';

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

      home: const Scaffold(body: Center(child: Text('Welcome to Taskati'))),
    );
  }
}
