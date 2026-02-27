import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/styles/colors.dart';
import 'package:taskati/core/styles/text_styles.dart';
import 'package:taskati/core/widgets/custom_svg_picture.dart';
import 'package:taskati/core/widgets/custom_text_form_field.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/core/widgets/tab_button.dart';
import 'package:taskati/features/home/screens/home_screen.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  String? path;
  final TextEditingController controller = TextEditingController();
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
                  ClipOval(
                    child: path != null
                        ? Image.file(
                            File(path!),
                            height: 170,
                            width: 170,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            AppImages.user,
                            height: 170,
                            width: 170,
                            fit: BoxFit.cover,
                          ),
                  ),
                  if (path != null)
                    Positioned(
                      right: 5,
                      bottom: 5,
                      child: GestureDetector(
                        onTap: () {
                          // show Dialog for deleting
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Image'),
                              backgroundColor: Colors.white,
                              content: const Text(
                                'Are you sure you want to delete this image?',
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('Yes'),
                                  onPressed: () {
                                    setState(() {
                                      path = null;
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                SimpleDialogOption(
                                  child: const Text('No'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },

                        // onTap: () {
                        //   setState(() {
                        //     path = null;
                        //   });
                        // },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.backgroundColor,
                          child: CustomSvgPicture(path: AppImages.deleteSvg),
                        ),
                      ),
                    ),
                ],
              ),
              Gap(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TabButton(
                    text: 'From Camera',
                    onPressed: () async {
                      var camera = await ImagePicker().pickImage(
                        source: ImageSource.camera,
                      );
                      if (camera != null) {
                        // Update UI or handle the picked image
                        setState(() {
                          path = camera.path;
                        });
                      }
                    },
                  ),
                  Gap(20),
                  TabButton(
                    text: 'From Gallery',
                    onPressed: () async {
                      var image = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                      );
                      if (image != null) {
                        // Update UI or handle the picked image
                        setState(() {
                          path = image.path;
                        });
                      }
                    },
                  ),
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
              CustomTextFormField(
                hintText: 'Enter your name',
                controller: controller,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(22, 5, 22, 30),
        child: MainButton(
          text: 'Let\'s Start!',
          onPressed: () {
            if (path != null && controller.text.isNotEmpty) {
              // navigate to next screen
              pushReplacement(context, HomeScreen());
            } else if (path == null && controller.text.isNotEmpty) {
              // showErrorDialog(context, 'select profile image');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please select a profile image.'),

                  backgroundColor: AppColors.redColor,
                  behavior: SnackBarBehavior.floating,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            } else if (path != null && controller.text.isEmpty) {
              // showErrorDialog(context, 'enter your name');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please enter your name.'),
                  backgroundColor: AppColors.redColor,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Please select a profile image and enter your name.',
                  ),
                  backgroundColor: AppColors.redColor,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
