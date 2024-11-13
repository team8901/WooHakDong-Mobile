import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/spacing.dart';

const List<Color> _defaultColors = [
  Color(0xFFB8BEC0),
  Color(0xFFE28A88),
  Color(0xFFF2B084),
  Color(0xFFF7E4A3),
  Color(0xFFB4D69A),
  Color(0xFFA2C4E4),
  Color(0xFF8596AF),
  Color(0xFFCC9BD9),
];

class ClubScheduleColorPicker extends StatelessWidget {
  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;

  const ClubScheduleColorPicker({
    super.key,
    required this.pickerColor,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Color>(
      tooltip: '',
      position: PopupMenuPosition.under,
      offset: Offset(0, 8.h),
      constraints: BoxConstraints(
        maxWidth: 200.w,
        minWidth: 200.w,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          padding: const EdgeInsets.all(defaultPaddingS),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: defaultGapXL,
              mainAxisSpacing: defaultGapXL,
            ),
            itemCount: _defaultColors.length,
            itemBuilder: (context, index) {
              final isSelected = pickerColor == _defaultColors[index];

              return InkWell(
                onTap: () {
                  onColorChanged(_defaultColors[index]);
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultBorderRadiusM / 2),
                    border: isSelected
                        ? Border.all(
                            color: _defaultColors[index],
                            width: 2,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          )
                        : null,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _defaultColors[index],
                      borderRadius: BorderRadius.circular(defaultBorderRadiusM / 2 - 2),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
      child: Container(
        width: 24.r,
        height: 24.r,
        decoration: BoxDecoration(
          color: pickerColor,
          borderRadius: BorderRadius.circular(defaultBorderRadiusM / 2),
        ),
      ),
    );
  }
}
