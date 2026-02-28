import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:taskati/core/styles/colors.dart';
import 'package:taskati/core/styles/text_styles.dart';

class DailyProgress extends StatelessWidget {
  const DailyProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '17 Feb',
                  style: TextStyles.caption1.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.backgroundColor,
                  ),
                ),
                Gap(12),
                Text(
                  'Your today’s task is almost done',
                  style: TextStyles.caption1.copyWith(
                    color: AppColors.backgroundColor,
                  ),
                ),
              ],
            ),
          ),
          // indicator package
          CircularPercentIndicator(
            radius: 38,
            lineWidth: 8,
            percent: 0.8,
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: Color(0XFF8764FF),
            progressColor: AppColors.backgroundColor,
            animation: true,
            animationDuration: 1500,
            center: Text(
              "80%",
              style: TextStyles.caption1.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.backgroundColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
