import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../themes/spacing.dart';

Future<DateTime?> clubDuesMonthPicker(BuildContext context, DateTime initialDate) async {
  return showMonthPicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2099),
    monthPickerDialogSettings: MonthPickerDialogSettings(
      headerSettings: PickerHeaderSettings(
        headerIconsSize: 20,
        headerIconsColor: context.colorScheme.inverseSurface,
        previousIcon: Symbols.keyboard_arrow_up_rounded,
        nextIcon: Symbols.keyboard_arrow_down_rounded,
        headerCurrentPageTextStyle: context.textTheme.titleSmall,
        headerSelectedIntervalTextStyle: context.textTheme.titleLarge,
        titleSpacing: 0,
        headerBackgroundColor: context.colorScheme.surfaceDim,
        headerPadding: const EdgeInsets.only(
          top: defaultPaddingM,
          left: defaultPaddingM,
          right: defaultPaddingM,
        ),
      ),
      dialogSettings: PickerDialogSettings(
        dismissible: true,
        dialogRoundedCornersRadius: defaultBorderRadiusL,
        dialogBackgroundColor: context.colorScheme.surfaceDim,
      ),
      buttonsSettings: PickerButtonsSettings(
        selectedMonthBackgroundColor: context.colorScheme.primary,
        selectedMonthTextColor: context.colorScheme.inversePrimary,
        selectedDateRadius: 4,
        unselectedMonthsTextColor: context.colorScheme.inverseSurface,
        currentMonthTextColor: context.colorScheme.primary,
        yearTextStyle: context.textTheme.titleSmall,
        monthTextStyle: context.textTheme.titleSmall,
      ),
    ),
  );
}