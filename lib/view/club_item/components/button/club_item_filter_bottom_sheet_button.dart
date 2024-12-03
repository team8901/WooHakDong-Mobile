import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class ClubItemFilterBottomSheetButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const ClubItemFilterBottomSheetButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: selected ? context.colorScheme.primary.withOpacity(0.1) : context.colorScheme.surfaceContainer,
      borderRadius: BorderRadius.circular(defaultBorderRadiusL),
      child: Ink(
        height: 32.h,
        padding: const EdgeInsets.symmetric(horizontal: defaultPaddingXS),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? context.colorScheme.primary : context.colorScheme.surfaceContainer,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(defaultBorderRadiusL),
          color: selected ? context.colorScheme.secondary : Colors.transparent,
        ),
        child: Center(
          child: Text(
            label,
            style: selected
                ? context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.primary)
                : context.textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}
