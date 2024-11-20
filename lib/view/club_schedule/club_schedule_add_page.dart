import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/repository/notification/notification_repository.dart';
import 'package:woohakdong/view/club_schedule/components/club_schedule_color_picker.dart';
import 'package:woohakdong/view/themes/custom_widget/button/custom_info_tooltip.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/club/club_id_provider.dart';
import 'package:woohakdong/view_model/schedule/components/schedule_state_provider.dart';

import '../../model/schedule/schedule.dart';
import '../../service/general/general_format.dart';
import '../../service/general/general_functions.dart';
import '../../view_model/schedule/components/schedule_state.dart';
import '../../view_model/schedule/schedule_provider.dart';
import '../themes/custom_widget/button/custom_bottom_button.dart';
import '../themes/custom_widget/interface/custom_counter_text_form_field.dart';
import '../themes/custom_widget/interface/custom_text_form_field.dart';
import '../themes/spacing.dart';
import 'components/club_schedule_datetime_picker.dart';
import 'components/club_schedule_controller.dart';

class ClubScheduleAddPage extends ConsumerStatefulWidget {
  final DateTime? initialScheduleDateTime;

  const ClubScheduleAddPage({
    super.key,
    this.initialScheduleDateTime,
  });

  @override
  ConsumerState<ClubScheduleAddPage> createState() => _ClubScheduleAddPageState();
}

class _ClubScheduleAddPageState extends ConsumerState<ClubScheduleAddPage> {
  final _formKey = GlobalKey<FormState>();
  late final ClubScheduleController _clubScheduleController;
  DateTime? _selectedDate;
  Color _pickerColor = const Color(0xFFB8BEC0);
  bool _isMailSend = false;

  @override
  void initState() {
    super.initState();
    _clubScheduleController = ClubScheduleController();
    _selectedDate = widget.initialScheduleDateTime;
  }

  @override
  void dispose() {
    _clubScheduleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentClubId = ref.watch(clubIdProvider);
    final scheduleState = ref.watch(scheduleStateProvider);
    final scheduleNotifier = ref.read(scheduleProvider.notifier);

    return PopScope(
      canPop: scheduleState != ScheduleState.adding,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('일정 등록'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(defaultPaddingM),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '일정 정보',
                    style: context.textTheme.labelLarge?.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  const Gap(defaultGapM),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          labelText: '제목',
                          controller: _clubScheduleController.title,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '일정 제목을 입력해 주세요';
                            }
                            return null;
                          },
                        ),
                      ),
                      const Gap(defaultGapM),
                      ClubScheduleColorPicker(
                        pickerColor: _pickerColor,
                        onColorChanged: (Color color) => setState(() => _pickerColor = color),
                      ),
                    ],
                  ),
                  const Gap(defaultGapM),
                  SizedBox(
                    width: double.infinity,
                    child: InkWell(
                      onTap: () async {
                        final scheduleDate = await showClubScheduleDateTimePicker(
                          context: context,
                          initialDate: _selectedDate,
                        );

                        if (scheduleDate != null) {
                          setState(() => _selectedDate = scheduleDate);
                        }
                      },
                      borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                      highlightColor: context.colorScheme.surfaceContainer,
                      child: Ink(
                        padding: const EdgeInsets.symmetric(
                          horizontal: defaultPaddingS,
                          vertical: defaultPaddingXS,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: context.colorScheme.surfaceContainer,
                          ),
                          borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                        ),
                        child: Text(
                          GeneralFormat.formatDateTime(_selectedDate),
                          style: context.textTheme.titleSmall?.copyWith(
                            color: context.colorScheme.inverseSurface,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(defaultGapM),
                  CustomCounterTextFormField(
                    labelText: '내용',
                    hintText: '100자 이내로 입력해 주세요',
                    minLines: 3,
                    maxLength: 100,
                    textInputAction: TextInputAction.done,
                    controller: _clubScheduleController.content,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '일정 내용을 입력해 주세요';
                      }
                      return null;
                    },
                  ),
                  const Gap(defaultGapXL),
                  Row(
                    children: [
                      Text(
                        '일정 메일',
                        style: context.textTheme.labelLarge?.copyWith(
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                      const Gap(defaultGapS / 2),
                      const CustomInfoTooltip(tooltipMessage: '일정을 추가하면 회원들에게 메일을 전송해요'),
                    ],
                  ),
                  const Gap(defaultGapM),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: context.colorScheme.surfaceContainer),
                      borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                    ),
                    padding: const EdgeInsets.only(
                      left: defaultPaddingS,
                      right: defaultPaddingS / 4,
                      top: defaultPaddingS / 4,
                      bottom: defaultPaddingS / 4,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('등록한 일정 메일 전송', style: context.textTheme.titleSmall),
                        ),
                        Transform.scale(
                          scale: 0.75,
                          child: CupertinoSwitch(
                            value: _isMailSend,
                            onChanged: (value) => setState(() => _isMailSend = value),
                            trackColor: context.colorScheme.surfaceContainer,
                            activeColor: context.colorScheme.primary,
                            thumbColor: context.colorScheme.surfaceDim,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: CustomBottomButton(
            onTap: () async {
              if (_formKey.currentState?.validate() == true) {
                try {
                  await _addSchedule(
                    currentClubId!,
                    Schedule(
                      scheduleTitle: _clubScheduleController.title.text,
                      scheduleContent: _clubScheduleController.content.text,
                      scheduleDateTime: _selectedDate,
                      scheduleColor: _pickerColor.value.toRadixString(16).toUpperCase(),
                    ),
                    scheduleNotifier,
                    _isMailSend,
                  );

                  if (context.mounted) {
                    Navigator.pop(context);

                    GeneralFunctions.toastMessage('일정이 등록되었어요');
                  }
                } catch (e) {
                  await GeneralFunctions.toastMessage('오류가 발생했어요\n다시 시도해 주세요');
                }
              }
            },
            buttonText: '등록',
            buttonColor: Theme.of(context).colorScheme.primary,
            buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
            isLoading: scheduleState == ScheduleState.adding,
          ),
        ),
      ),
    );
  }

  Future<void> _addSchedule(
    int clubId,
    Schedule scheduleInfo,
    ScheduleNotifier scheduleNotifier,
    bool isMailSend,
  ) async {
    final NotificationRepository notificationRepository = NotificationRepository();

    try {
      final scheduleId = await scheduleNotifier.addSchedule(
        scheduleInfo.scheduleTitle!,
        scheduleInfo.scheduleContent!,
        scheduleInfo.scheduleDateTime!,
        scheduleInfo.scheduleColor!,
      );

      if (isMailSend) {
        await notificationRepository.sendClubScheduleNotification(clubId, scheduleId);
      }
    } catch (e) {
      rethrow;
    }
  }
}
