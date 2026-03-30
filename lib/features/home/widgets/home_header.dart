import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/functions/extensions.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/services/hive_helper.dart';
// import 'package:taskati/core/services/shared_pref.dart';
import 'package:taskati/core/styles/text_styles.dart';
import 'package:taskati/features/edit_profile/screens/edit_profile_screen.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  String name = '';
  String path = '';
  @override
  void initState() {
    super.initState();
    // getUserData();
    getCachedData();
  }

  // Future<void> getUserData() async {
  //   name = SharedPref.getString(SharedPref.nameKey);
  //   path = SharedPref.getString(SharedPref.imageKey);
  //   setState(() {});
  // }
  Future<void> getCachedData() async {
    name = HiveHelper.getData(HiveHelper.nameKey);
    path = HiveHelper.getData(HiveHelper.imageKey);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveHelper.userBox.listenable(),
      builder: (context, box, child) {
        final name = box.get(HiveHelper.nameKey) ?? '';
        final path = box.get(HiveHelper.imageKey) ?? '';

        return Row(
          children: [
            GestureDetector(
              onTap: () {
                pushTo(context, const EditProfileScreen());
              },
              child: ClipOval(
                child: path.isEmpty
                    ? Image.asset(AppImages.user, width: 50, height: 50)
                    : Image.file(
                        File(path),
                        width: 55,
                        height: 55,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(AppImages.user, height: 50);
                        },
                      ),
              ),
            ),
            Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello!', style: TextStyles.caption1),
                  Text(name, style: TextStyles.title),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                bool isDarkMode = context.isDarkMode;
                HiveHelper.cacheData(HiveHelper.isDarkModeKey, !isDarkMode);
                setState(() {});
              },
              icon: Icon(
                context.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              ),
            ),
          ],
        );
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Row(
  //     children: [
  //       GestureDetector(
  //         //         onTap: () {
  //         // pushTo(context, const ProfileScreen());
  //         // },
  //         onTap: () async {
  //           await pushTo(context, const ProfileScreen());
  //           await getCachedData();
  //           setState(() {});
  //         },
  //         child: ClipOval(
  //           child: path.isEmpty
  //               ? Image.asset(AppImages.user, width: 50, height: 50)
  //               : Image.file(
  //                   File(path),
  //                   width: 55,
  //                   height: 55,
  //                   fit: BoxFit.cover,
  //                   errorBuilder: (context, error, stackTrace) {
  //                     return Image.asset(AppImages.user, height: 50);
  //                   },
  //                 ),
  //         ),
  //       ),
  //       Gap(12),
  //       Expanded(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text('Hello!', style: TextStyles.caption1),
  //             Text(name, style: TextStyles.title),
  //           ],
  //         ),
  //       ),
  //       IconButton(
  //         onPressed: () {
  //           bool isDarkMode = context.isDarkMode;
  //           HiveHelper.cacheData(HiveHelper.isDarkModeKey, !isDarkMode);
  //           setState(() {});
  //         },
  //         icon: Icon(context.isDarkMode ? Icons.light_mode : Icons.dark_mode),
  //       ),
  //     ],
  //   );
  // }
}
