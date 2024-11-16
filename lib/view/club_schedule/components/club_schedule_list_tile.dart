import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_tap_debouncer.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../model/schedule/schedule.dart';
import '../../themes/spacing.dart';

class ClubScheduleListTile extends ConsumerWidget {
  final Schedule schedule;
  final Future<void> Function()? onTap;
  final Color? highlightColor;

  const ClubScheduleListTile({
    super.key,
    required this.schedule,
    this.onTap,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomTapDebouncer(
      onTap: onTap,
      builder: (context, onTap) {
        return InkWell(
          onTap: onTap,
          highlightColor: highlightColor ?? context.colorScheme.surfaceContainer,
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
                        Text(
                          schedule.scheduleTitle!,
                          style: context.textTheme.bodyLarge,
                        ),
                        const Gap(defaultGapS / 4),
                        Text(
                          DateFormat('a h:mm', 'ko_KR').format(schedule.scheduleDateTime!),
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
      },
    );
  }
}
