import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/service/general/general_functions.dart';
import 'package:woohakdong/view/themes/custom_widget/dialog/custom_interaction_dialog.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../model/schedule/schedule.dart';
import '../../view_model/schedule/schedule_provider.dart';
import '../themes/custom_widget/interface/custom_info_content.dart';
import '../themes/spacing.dart';
import 'club_schedule_edit_page.dart';

class ClubScheduleDetailPage extends ConsumerWidget {
  const ClubScheduleDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleInfo = ref.watch(scheduleProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(
              Symbols.more_vert_rounded,
              grade: 600,
            ),
            onSelected: (value) async {
              switch (value) {
                case 'edit':
                  _pushItemEditPage(context, scheduleInfo);
                  break;
                case 'delete':
                  await _deleteSchedule(context, ref, scheduleInfo.scheduleId!);
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'edit',
                child: Row(
                  children: [
                    const Icon(Symbols.border_color_rounded, size: 16),
                    const Gap(defaultGapM),
                    Text(
                      '일정 수정',
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: Row(
                  children: [
                    const Icon(Symbols.delete_rounded, size: 16),
                    const Gap(defaultGapM),
                    Text(
                      '일정 삭제',
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultPaddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '일정 정보',
                style: context.textTheme.labelLarge,
              ),
              const Gap(defaultGapM),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: context.colorScheme.surfaceContainer),
                        borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: defaultPaddingS,
                        vertical: defaultPaddingXS,
                      ),
                      child: CustomInfoContent(
                        infoContent: scheduleInfo.scheduleTitle!,
                        icon: Icon(
                          Symbols.title_rounded,
                          size: 16,
                          color: context.colorScheme.outline,
                        ),
                      ),
                    ),
                  ),
                  const Gap(defaultGapM),
                  Container(
                    width: 24.r,
                    height: 24.r,
                    decoration: BoxDecoration(
                      color: Color(int.parse('0x${scheduleInfo.scheduleColor!}')),
                      borderRadius: BorderRadius.circular(defaultBorderRadiusM / 2),
                    ),
                  ),
                ],
              ),
              const Gap(defaultGapM),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: context.colorScheme.surfaceContainer),
                  borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPaddingS,
                  vertical: defaultPaddingXS,
                ),
                child: CustomInfoContent(
                  infoContent: GeneralFunctions.formatDateTime(scheduleInfo.scheduleDateTime!),
                  icon: Icon(
                    Symbols.schedule_rounded,
                    size: 16,
                    color: context.colorScheme.outline,
                  ),
                ),
              ),
              const Gap(defaultGapM),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: context.colorScheme.surfaceContainer),
                  borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPaddingS,
                  vertical: defaultPaddingXS,
                ),
                child: CustomInfoContent(
                  infoContent: scheduleInfo.scheduleContent!,
                  icon: Icon(
                    Symbols.info_rounded,
                    size: 16,
                    color: context.colorScheme.outline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pushItemEditPage(BuildContext context, Schedule scheduleInfo) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ClubScheduleEditPage(scheduleInfo: scheduleInfo),
      ),
    );
  }

  Future<void> _deleteSchedule(BuildContext context, WidgetRef ref, int scheduleId) async {
    try {
      final bool? isDelete = await showDialog<bool>(
        context: context,
        builder: (context) => const CustomInteractionDialog(
          dialogTitle: '일정 삭제',
          dialogContent: '일정을 삭제하면 되돌릴 수 없어요.',
        ),
      );

      if (isDelete == true) {
        await ref.read(scheduleProvider.notifier).deleteSchedule(scheduleId);

        if (context.mounted) {
          GeneralFunctions.toastMessage('일정이 삭제되었어요');
          Navigator.pop(context);
        }
      }
    } catch (e) {
      GeneralFunctions.toastMessage('오류가 발생했어요\n다시 시도해 주세요');
    }
  }
}
