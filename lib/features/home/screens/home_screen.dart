// import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/functions/extensions.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/hive_helper.dart';
// import 'package:taskati/core/models/task_model.dart';
// import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/core/styles/colors.dart';
import 'package:taskati/core/styles/text_styles.dart';
import 'package:taskati/features/add_task/screens/add_edit_task_screen.dart';

import 'package:taskati/features/home/widgets/daily_progress.dart';
import 'package:taskati/features/home/widgets/home_date_picker.dart';

import 'package:taskati/features/home/widgets/home_header.dart';
import 'package:taskati/features/home/widgets/tasks/tasks_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedDate = DateFormat('dd MMM, yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          // backgroundColor: AppColors.primaryColor,
          // foregroundColor: AppColors.backgroundColor,
          onPressed: () {
            pushTo(context, AddEditTaskScreen(selectedDate: selectedDate,));
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                HomeHeader(),
                Gap(24),
                // DailyProgress(),
                DailyProgress(selectedDate: selectedDate),
                Gap(24),
                HomeDatePicker(
                  onDateChange: (date) {
                    setState(() {
                      //  print(date);    // 2026-03-24 00:00:00.000          // 2026-03-20 00:00:00.000
                      selectedDate = DateFormat('dd MMM, yyyy').format(date);
                      // print(selectedDate);    //  20 Mar, 2026
                    });
                  },
                ),
                Gap(16),
                _filterTabs(context),
                Gap(20),
                _tasksList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ButtonsTabBar _filterTabs(BuildContext context) {
    return ButtonsTabBar(
      backgroundColor: AppColors.primaryColor,
      borderWidth: 3,
      borderColor: Colors.black,
      labelStyle: TextStyles.caption1.copyWith(
        color: AppColors.backgroundColor,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: TextStyles.caption1.copyWith(
        color: context.isDarkMode
            ? AppColors.backgroundColor
            : AppColors.primaryColor,
      ),
      // unselectedLabelStyle: TextStyles.caption1.copyWith(
      //   color: AppColors.primaryColor,
      //   // fontWeight: FontWeight.bold,
      // ),

      // unselectedBackgroundColor: AppColors.accentColor,
      unselectedBackgroundColor: context.hoverColor,
      radius: 12,
      buttonMargin: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      contentCenter: true,
      width: (MediaQuery.sizeOf(context).width - 40) / 3,
      tabs: [
        Tab(text: 'All'),
        Tab(text: 'In Progress'),
        Tab(text: 'Completed'),
      ],
    );
  }

  Expanded _tasksList() {
    return Expanded(
      child: ValueListenableBuilder<Box<TaskModel>>(
        valueListenable: HiveHelper.taskBox.listenable(),
        builder: (context, box, child) {
          // final tasks = HiveHelper.taskBox.values.toList();
          final List<TaskModel> dailyTasks = [];
          for (var task in box.values) {
            if (task.date == selectedDate) {
              dailyTasks.add(task);
            }
          }
          final inProgressTasks = dailyTasks
              .where((task) => !task.isCompleted)
              .toList();
          final completedTasks = dailyTasks
              .where((task) => task.isCompleted)
              .toList();
          return TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              TasksBuilder(tasks: dailyTasks),
              TasksBuilder(tasks: inProgressTasks),
              TasksBuilder(tasks: completedTasks),
            ],
          );
        },
      ),
    );
  }
}
