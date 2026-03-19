import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:taskati/core/functions/extensions.dart';
import 'package:taskati/core/styles/colors.dart';
import 'package:taskati/core/styles/text_styles.dart';

class HomeDatePicker extends StatelessWidget {
  final Function(DateTime) onDateChange;

  const HomeDatePicker({super.key, required this.onDateChange});
  @override
  Widget build(BuildContext context) {
    return EasyDateTimeLine(
      onDateChange: onDateChange,

      initialDate: DateTime.now(),
      // after ==> make the showHeader is true
      headerProps: const EasyHeaderProps(showHeader: false),

      dayProps: EasyDayProps(
        height: 100,
        width: 75,

        activeDayStyle: DayStyle(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.primaryColor,
          ),
          dayNumStyle: TextStyles.title.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.backgroundColor,
          ),
          dayStrStyle: TextStyles.caption2.copyWith(
            color: AppColors.backgroundColor,
          ),
          monthStrStyle: TextStyles.caption2.copyWith(
            color: AppColors.backgroundColor,
          ),
        ),

        // inactiveDayStyle: DayStyle(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(16),
        //     color: Colors.white,
        //     border: Border.all(color: Colors.grey.shade200, width: 1),
        //   ),
        //   dayNumStyle: TextStyles.title.copyWith(fontWeight: FontWeight.w600),
        //   dayStrStyle: TextStyles.caption2,
        //   monthStrStyle: TextStyles.caption2,
        // ),
        inactiveDayStyle: DayStyle(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: context.cardColor, // بدل Colors.white

            border: Border.all(
              color: context.isDarkMode
                  ? Colors.transparent
                  : Colors.grey.shade200,
              width: 1,
            ),
          ),
          dayNumStyle: TextStyles.title.copyWith(
            fontWeight: FontWeight.w600,
            color: context.theme.colorScheme.onSurface,
          ),
          dayStrStyle: TextStyles.caption2.copyWith(
            color: context.theme.colorScheme.onSurface,
          ),
          monthStrStyle: TextStyles.caption2.copyWith(
            color: context.theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
