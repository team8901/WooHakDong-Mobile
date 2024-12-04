import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../themes/spacing.dart';

class ClubItemFilterButton extends StatelessWidget {
  final VoidCallback onTap;
  final String content;
  final bool isActive;
  final IconData? icon;

  const ClubItemFilterButton({
    super.key,
    required this.onTap,
    required this.content,
    this.isActive = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: context.colorScheme.surfaceContainer,
      splashColor: isActive ? context.colorScheme.primary.withOpacity(0.1) : context.colorScheme.surfaceContainer,
      borderRadius: BorderRadius.circular(defaultBorderRadiusL),
      child: Ink(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: defaultPaddingXS),
        decoration: BoxDecoration(
          border: Border.all(
            color: isActive ? context.colorScheme.primary : context.colorScheme.surfaceContainer,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(defaultBorderRadiusL),
          color: isActive ? context.colorScheme.secondary : Colors.transparent,
        ),
        child: Center(
          child: Row(
            children: [
              Text(
                content,
                style: isActive
                    ? context.textTheme.labelLarge?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      )
                    : context.textTheme.labelLarge,
              ),
              if (icon != null) ...[
                const Gap(defaultGapS / 2),
                Icon(
                  icon,
                  size: 12,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
