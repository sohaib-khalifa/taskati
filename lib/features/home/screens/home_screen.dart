import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:taskati/features/home/widgets/daily_progress.dart';

import 'package:taskati/features/home/widgets/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [HomeHeader(), Gap(24), DailyProgress()]),
        ),
      ),
    );
  }
}
