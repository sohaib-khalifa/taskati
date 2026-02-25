import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/styles/colors.dart';
import 'package:taskati/core/styles/text_styles.dart';
import 'package:taskati/core/widgets/custom_text_form_field.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/core/widgets/tab_button.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Complete Profile')),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(40),
              Row(
                children: [
                  Text(
                    'Profile Image',
                    style: TextStyles.caption1.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),
              Gap(20),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 85,
                    backgroundColor: AppColors.accentColor,
                  ),
                ],
              ),
              Gap(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TabButton(text: 'From Camera', onPressed: () {}),
                  Gap(20),
                  TabButton(text: 'From Gallery', onPressed: () {}),
                ],
              ),
              Gap(40),
              Row(
                children: [
                  Text(
                    'Your Name',
                    style: TextStyles.caption1.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),
              Gap(8),
              CustomTextFormField(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(22, 5, 22, 30),
        child: MainButton(text: 'Let\'s Start!', onPressed: () {}),
      ),
    );
  }
}
