import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/core/styles/colors.dart';
import 'package:taskati/core/styles/text_styles.dart';

class DailyProgress extends StatelessWidget {
  const DailyProgress({super.key, required this.selectedDate});
  final String selectedDate;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<TaskModel>>(
      valueListenable: HiveHelper.taskBox.listenable(),
      builder: (context, box, child) {
        List<TaskModel> dailyTasks = [];
        for (var task in box.values) {
          // if (task.date == DateFormat('dd MMM, yyyy').format(DateTime.now()))
          if (task.date == selectedDate) {
            dailyTasks.add(task);
          }
        }

        final completedTasks = dailyTasks
            .where((task) => task.isCompleted)
            .toList();
        final totalTasks = dailyTasks.length;
        final progressPercentage = totalTasks == 0
            ? 0
            : (completedTasks.length / totalTasks) * 100;
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
                      // DateFormat("EEE, dd MMM").format(DateTime.now()),
                      DateFormat(
                        "EEE, dd MMM",
                      ).format(DateFormat('dd MMM, yyyy').parse(selectedDate)),
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
                // percent: 0.8,
                percent: progressPercentage / 100,
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: Color(0XFF8764FF),
                progressColor: AppColors.backgroundColor,
                animation: true,
                animationDuration: 1500,
                center: Text(
                  '${progressPercentage.toStringAsFixed(0)}%',
                  style: TextStyles.caption1.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.backgroundColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
