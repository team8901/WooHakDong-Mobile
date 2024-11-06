import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:woohakdong/view/club_schedule/components/club_schedule_color_picker.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/schedule/components/schedule_state_provider.dart';

import '../../model/schedule/schedule.dart';
import '../../service/general/general_functions.dart';
import '../../view_model/schedule/components/schedule_state.dart';
import '../../view_model/schedule/schedule_provider.dart';
import '../themes/custom_widget/button/custom_bottom_button.dart';
import '../themes/custom_widget/interface/custom_counter_text_form_field.dart';
import '../themes/custom_widget/interface/custom_text_form_field.dart';
import '../themes/spacing.dart';

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
  DateTime? _selectedDate;
  Color _pickerColor = const Color(0xFFC5C6C7);
  String? _dateErrorText;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialScheduleDateTime;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheduleInfo = ref.watch(scheduleProvider);
    final scheduleState = ref.watch(scheduleStateProvider);
    final scheduleNotifier = ref.read(scheduleProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('일정 추가'),
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
                        onSaved: (value) => scheduleInfo.scheduleTitle = value,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: InkWell(
                        onTap: () async {
                          final DateTime? scheduleDate = await showOmniDateTimePicker(
                            context: context,
                            initialDate: _selectedDate ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2099),
                            is24HourMode: true,
                            isShowSeconds: false,
                            isForce2Digits: false,
                            borderRadius: const BorderRadius.all(Radius.circular(defaultBorderRadiusL)),
                            padding: const EdgeInsets.all(defaultPaddingS * 2),
                            insetPadding: const EdgeInsets.all(defaultPaddingM),
                            separator: Divider(
                              color: context.colorScheme.surfaceContainer,
                              thickness: 0.8,
                              height: 0,
                            ),
                            theme: ThemeData().copyWith(
                              colorScheme: context.colorScheme,
                              textTheme: context.textTheme,
                            ),
                          );

                          if (scheduleDate != null) {
                            setState(
                              () => _selectedDate = scheduleDate,
                            );
                            scheduleInfo.scheduleDateTime = scheduleDate;
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
                              color: _dateErrorText != null
                                  ? context.colorScheme.error
                                  : context.colorScheme.surfaceContainer,
                            ),
                            borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                          ),
                          child: Text(
                            (_selectedDate == null) ? '날짜 및 시각' : GeneralFunctions.formatDateTime(_selectedDate),
                            style: context.textTheme.titleSmall?.copyWith(
                              color: (_selectedDate == null)
                                  ? context.colorScheme.outline
                                  : context.colorScheme.inverseSurface,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (_dateErrorText != null)
                      Padding(
                        padding: const EdgeInsets.only(top: defaultPaddingS / 4, left: defaultPaddingS),
                        child: Text(
                          _dateErrorText!,
                          style: context.textTheme.labelLarge?.copyWith(
                            color: context.colorScheme.error,
                          ),
                        ),
                      ),
                  ],
                ),
                const Gap(defaultGapM),
                CustomCounterTextFormField(
                  labelText: '내용',
                  hintText: '200자 이내로 입력해 주세요',
                  minLines: 4,
                  maxLength: 200,
                  textInputAction: TextInputAction.done,
                  onSaved: (value) => scheduleInfo.scheduleContent = value,
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
            setState(() => _dateErrorText = null);

            bool isDateTimeValid = true;

            if (_selectedDate == null) {
              setState(() => _dateErrorText = '날짜 및 시각을 선택해 주세요');
              isDateTimeValid = false;
            }

            if (_formKey.currentState?.validate() == true && isDateTimeValid) {
              _formKey.currentState?.save();
              scheduleInfo.scheduleColor = _pickerColor.value.toRadixString(16).toUpperCase();
              try {
                await _addScheduleToServer(scheduleInfo, scheduleNotifier);

                if (context.mounted) {
                  Navigator.pop(context);
                  GeneralFunctions.toastMessage('일정이 추가되었어요');
                }
              } catch (e) {
                await GeneralFunctions.toastMessage('오류가 발생했어요\n다시 시도해 주세요');
              }
            }
          },
          buttonText: '추가',
          buttonColor: Theme.of(context).colorScheme.primary,
          buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
          isLoading: scheduleState == ScheduleState.adding,
        ),
      ),
    );
  }

  Future<void> _addScheduleToServer(
    Schedule scheduleInfo,
    ScheduleNotifier scheduleNotifier,
  ) async {
    try {
      await scheduleNotifier.addSchedule(
        scheduleInfo.scheduleTitle!,
        scheduleInfo.scheduleContent!,
        scheduleInfo.scheduleDateTime!,
        scheduleInfo.scheduleColor!,
      );
    } catch (e) {
      rethrow;
    }
  }
}
