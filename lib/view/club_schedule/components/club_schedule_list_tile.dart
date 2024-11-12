import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../model/schedule/schedule.dart';
import '../../../view_model/schedule/schedule_provider.dart';
import '../../themes/spacing.dart';
import '../club_schedule_detail_page.dart';

class ClubScheduleListTile extends ConsumerWidget {
  final Schedule schedule;

  const ClubScheduleListTile({
    super.key,
    required this.schedule,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        await ref.read(scheduleProvider.notifier).getScheduleInfo(schedule.scheduleId!);

        if (context.mounted) {
          _pushScheduleDetailPage(context);
        }
      },
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
  }

  void _pushScheduleDetailPage(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => const ClubScheduleDetailPage()),
    );
  }
}
