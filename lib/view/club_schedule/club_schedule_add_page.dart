import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
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
  Color _pickerColor = const Color(0xFFB8BEC0);

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
                SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    onTap: () async {
                      await showBoardDateTimePicker(
                        context: context,
                        pickerType: DateTimePickerType.datetime,
                        initialDate: _selectedDate ?? DateTime.now(),
                        minimumDate: DateTime(2000),
                        maximumDate: DateTime(2099),
                        onChanged: (scheduleDate) => setState(() => _selectedDate = scheduleDate),
                        useSafeArea: true,
                        enableDrag: false,
                        showDragHandle: true,
                        options: BoardDateTimeOptions(
                          backgroundDecoration: BoxDecoration(
                            color: context.colorScheme.surfaceDim,
                            borderRadius: BorderRadius.circular(defaultBorderRadiusL),
                          ),
                          weekend: BoardPickerWeekendOptions(
                            saturdayColor: context.colorScheme.onSurface,
                            sundayColor: context.colorScheme.onSurface,
                          ),
                          languages: const BoardPickerLanguages(locale: 'ko_KR', today: '오늘', tomorrow: '내일'),
                          textColor: context.colorScheme.inverseSurface,
                          backgroundColor: context.colorScheme.surfaceDim,
                          foregroundColor: context.colorScheme.surfaceContainer,
                          activeColor: context.colorScheme.primary,
                          activeTextColor: context.colorScheme.inversePrimary,
                          inputable: false,
                        ),
                      );
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
                        GeneralFunctions.formatDateTime(_selectedDate),
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
            if (_formKey.currentState?.validate() == true) {
              _formKey.currentState?.save();
              scheduleInfo.scheduleDateTime = _selectedDate;
              scheduleInfo.scheduleColor = _pickerColor.value.toRadixString(16).toUpperCase();

              try {
                await _addSchedule(scheduleInfo, scheduleNotifier);

                if (context.mounted) {
                  GeneralFunctions.toastMessage('일정이 추가되었어요');
                  Navigator.pop(context);
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

  Future<void> _addSchedule(
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
