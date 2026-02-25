import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/styles/colors.dart';
import 'package:taskati/core/styles/text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.backgroundColor,
          width: double.infinity,
          height: double.infinity,
        ),
        Image.asset(
          AppImages.bg,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),

        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              spacing: 18,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(AppImages.logoJson, width: 250),
                const Text('Taskati', style: TextStyles.headline),
                Text(
                  'It’s time to get organized',
                  style: TextStyles.caption1.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
