import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/club_schedule/components/club_schedule_controller.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../model/schedule/schedule.dart';
import '../../service/general/general_format.dart';
import '../../service/general/general_functions.dart';
import '../../view_model/schedule/components/schedule_state.dart';
import '../../view_model/schedule/components/schedule_state_provider.dart';
import '../../view_model/schedule/schedule_provider.dart';
import '../themes/custom_widget/button/custom_bottom_button.dart';
import '../themes/custom_widget/interface/custom_counter_text_form_field.dart';
import '../themes/custom_widget/interface/custom_text_form_field.dart';
import '../themes/spacing.dart';
import 'components/club_schedule_color_picker.dart';
import 'components/club_schedule_datetime_picker.dart';

class ClubScheduleEditPage extends ConsumerStatefulWidget {
  final Schedule scheduleInfo;

  const ClubScheduleEditPage({
    super.key,
    required this.scheduleInfo,
  });

  @override
  ConsumerState<ClubScheduleEditPage> createState() => _ClubScheduleEditPageState();
}

class _ClubScheduleEditPageState extends ConsumerState<ClubScheduleEditPage> {
  final _formKey = GlobalKey<FormState>();
  late final ClubScheduleController _clubScheduleController;
  DateTime? _selectedDate;
  Color? _pickerColor;

  @override
  void initState() {
    super.initState();
    _clubScheduleController = ClubScheduleController();
    _selectedDate = widget.scheduleInfo.scheduleDateTime;
    _pickerColor = Color(int.parse('0x${widget.scheduleInfo.scheduleColor!}'));
  }

  @override
  void dispose() {
    _clubScheduleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _clubScheduleController.updateFromClubScheduleInfo(widget.scheduleInfo);
    final scheduleState = ref.watch(scheduleStateProvider);
    final scheduleNotifier = ref.read(scheduleProvider.notifier);

    return PopScope(
      canPop: scheduleState != ScheduleState.adding,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('일정 수정'),
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
                          controller: _clubScheduleController.title,
                          labelText: '제목',
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
                        pickerColor: _pickerColor!,
                        onColorChanged: (Color color) => setState(() => _pickerColor = color),
                      ),
                    ],
                  ),
                  const Gap(defaultGapM),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              (_selectedDate == null) ? '날짜 및 시각' : GeneralFormat.formatDateTime(_selectedDate),
                              style: context.textTheme.titleSmall?.copyWith(
                                color: (_selectedDate == null)
                                    ? context.colorScheme.outline
                                    : context.colorScheme.inverseSurface,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(defaultGapM),
                  CustomCounterTextFormField(
                    controller: _clubScheduleController.content,
                    labelText: '내용',
                    hintText: '200자 이내로 입력해 주세요',
                    minLines: 4,
                    maxLength: 200,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '일정 내용을 입력해 주세요';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: CustomBottomButton(
            onTap: () async {
              try {
                await _editSchedule(
                  scheduleNotifier,
                  widget.scheduleInfo.scheduleId!,
                  _selectedDate!,
                  _pickerColor!.value.toRadixString(16).toUpperCase(),
                );

                if (context.mounted) {
                  GeneralFunctions.toastMessage('일정이 수정되었어요');
                  Navigator.pop(context);
                }
              } catch (e) {
                await GeneralFunctions.toastMessage('오류가 발생했어요\n다시 시도해 주세요');
              }
            },
            buttonText: '저장',
            buttonColor: Theme.of(context).colorScheme.primary,
            buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
            isLoading: scheduleState == ScheduleState.adding,
          ),
        ),
      ),
    );
  }

  Future<void> _editSchedule(
    ScheduleNotifier scheduleNotifier,
    int scheduleId,
    DateTime scheduleDateTime,
    String scheduleColor,
  ) async {
    try {
      await scheduleNotifier.updateSchedule(
        scheduleId,
        _clubScheduleController.title.text,
        _clubScheduleController.content.text,
        scheduleDateTime,
        scheduleColor,
      );
    } catch (e) {
      rethrow;
    }
  }
}
