import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/service/general/general_functions.dart';
import 'package:woohakdong/view/themes/custom_widget/dialog/custom_interaction_dialog.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/club/club_id_provider.dart';

import '../../model/schedule/schedule.dart';
import '../../repository/notification/notification_repository.dart';
import '../../service/general/general_format.dart';
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
          IconButton(
            onPressed: () async => await _sendScheduleEmail(ref, context, scheduleInfo.scheduleId!),
            icon: const Icon(Symbols.forward_to_inbox_rounded),
          ),
          IconButton(
            onPressed: () => _pushScheduleEditPage(context, scheduleInfo),
            icon: const Icon(Symbols.edit_rounded),
          ),
          IconButton(
            onPressed: () async => await _deleteSchedule(context, ref, scheduleInfo.scheduleId!),
            icon: const Icon(Symbols.delete_rounded),
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
                  infoContent: GeneralFormat.formatDateTime(scheduleInfo.scheduleDateTime!),
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
                    Symbols.help_rounded,
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

  Future<void> _sendScheduleEmail(WidgetRef ref, BuildContext context, int scheduleId) async {
    final currentClubId = ref.watch(clubIdProvider);
    final NotificationRepository notificationRepository = NotificationRepository();

    try {
      final bool? isSend = await showDialog<bool>(
        context: context,
        builder: (context) => CustomInteractionDialog(
          dialogTitle: '동아리 일정 메일 전송',
          dialogContent: '동아리 일정을 회원들에게 메일로 전송할 수 있어요.',
          dialogButtonText: '전송',
          dialogButtonColor: context.colorScheme.primary,
        ),
      );

      if (isSend != true) return;

      await notificationRepository.sendClubScheduleNotification(currentClubId!, scheduleId);
      GeneralFunctions.toastMessage('동아리 정보를 회원들에게 메일로 전송했어요');
    } catch (e) {
      GeneralFunctions.toastMessage('오류가 발생했어요\n다시 시도해 주세요');
    }
  }

  void _pushScheduleEditPage(BuildContext context, Schedule scheduleInfo) {
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
