import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../model/schedule/schedule.dart';
import '../../themes/spacing.dart';

class ClubScheduleListTile extends StatelessWidget {
  const ClubScheduleListTile({
    super.key,
    required this.schedule,
  });

  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      highlightColor: context.colorScheme.surfaceContainer,
      child: Ink(
        padding: const EdgeInsets.all(defaultPaddingM),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Row(
            children: [
              Container(
                width: 6,
                height: 44.h,
                decoration: BoxDecoration(
                  color: Color(int.parse('0x${schedule.scheduleColor!}')),
                  borderRadius: BorderRadius.circular(defaultBorderRadiusM / 2),
                ),
              ),
              const Gap(defaultGapM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(schedule.scheduleTitle!, style: context.textTheme.bodyLarge),
                    const Gap(defaultGapS / 4),
                    Text(
                      DateFormat('H:mm').format(schedule.scheduleDateTime!),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}