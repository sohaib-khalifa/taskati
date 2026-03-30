import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/functions/extensions.dart';
import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/core/styles/colors.dart';
import 'package:taskati/core/styles/text_styles.dart';
import 'package:taskati/core/widgets/custom_svg_picture.dart';
import 'package:taskati/core/widgets/custom_text_form_field.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/core/widgets/tab_button.dart';
import 'package:taskati/core/helpers/error_snackbar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? path;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    controller.text = HiveHelper.getData(HiveHelper.nameKey) ?? '';
    path = HiveHelper.getData(HiveHelper.imageKey);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),

      body: Padding(
        padding: const EdgeInsets.all(22),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(40),

              /// Profile Image Title
              Row(
                children: [
                  Text(
                    'Profile Image',
                    style: TextStyles.caption1.copyWith(
                      // color: AppColors.secondaryColor,
                      color: context.isDarkMode
                          ? Colors.white
                          : AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),

              const Gap(20),

              _profileImage(),

              const Gap(30),

              /// Buttons
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
                        setState(() {
                          path = camera.path;
                        });
                      }
                    },
                  ),
                  const Gap(20),
                  TabButton(
                    text: 'From Gallery',
                    onPressed: () async {
                      var image = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                      );
                      if (image != null) {
                        setState(() {
                          path = image.path;
                        });
                      }
                    },
                  ),
                ],
              ),

              const Gap(40),

              /// Name Title
              Row(
                children: [
                  Text(
                    'Your Name',
                    style: TextStyles.caption1.copyWith(
                      // color: AppColors.secondaryColor,
                      color: context.isDarkMode
                          ? Colors.white
                          : AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),

              const Gap(8),

              CustomTextFormField(
                controller: controller,
                hintText: 'Enter your name',
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(22, 5, 22, 30),
        child: MainButton(
          text: 'Save',
          onPressed: () async {
            if (path != null && controller.text.isNotEmpty) {
              await HiveHelper.setUserData(controller.text, path!);

              Navigator.pop(context); 
            } else if (path == null && controller.text.isNotEmpty) {
              showErrorSnackBar(context, 'Please select a profile image.');
            } else if (path != null && controller.text.isEmpty) {
              showErrorSnackBar(context, 'Please enter your name.');
            } else {
              showErrorSnackBar(
                context,
                'Please select a profile image and enter your name.',
              );
            }
          },
        ),
      ),
    );
  }

  Widget _profileImage() {
    return Stack(
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
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Image'),
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
                      TextButton(
                        child: const Text('No'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.backgroundColor,
                child: CustomSvgPicture(path: AppImages.deleteSvg),
              ),
            ),
          ),
      ],
    );
  }
}
