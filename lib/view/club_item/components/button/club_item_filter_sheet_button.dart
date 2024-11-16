import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class ClubItemFilterSheetButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const ClubItemFilterSheetButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: context.colorScheme.onInverseSurface,
      borderRadius: BorderRadius.circular(defaultBorderRadiusL / 2),
      child: Ink(
        height: 32.h,
        padding: const EdgeInsets.symmetric(horizontal: defaultPaddingXS),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadiusL / 2),
          border: Border.all(
            color: selected ? context.colorScheme.primary : context.colorScheme.onInverseSurface,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: selected
                ? context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.primary)
                : context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
          ),
        ),
      ),
    );
  }
}
