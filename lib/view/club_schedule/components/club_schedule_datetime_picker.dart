import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

Future<DateTime?> showClubScheduleDateTimePicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTimePickerType? pickerType,
}) async {
  DateTime? selectedDate;
  await showBoardDateTimePicker(
    context: context,
    pickerType: pickerType ?? DateTimePickerType.datetime,
    initialDate: initialDate ?? DateTime.now(),
    minimumDate: DateTime(2000),
    maximumDate: DateTime(2099),
    onChanged: (date) => selectedDate = date,
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
      languages: const BoardPickerLanguages(
        locale: 'ko_KR',
        today: '오늘',
        tomorrow: '내일',
      ),
      textColor: context.colorScheme.inverseSurface,
      backgroundColor: context.colorScheme.surfaceDim,
      foregroundColor: context.colorScheme.surfaceContainer,
      activeColor: context.colorScheme.primary,
      activeTextColor: context.colorScheme.inversePrimary,
      inputable: true,
    ),
  );
  return selectedDate;
}
