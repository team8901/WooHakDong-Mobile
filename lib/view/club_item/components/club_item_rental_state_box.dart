import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../themes/spacing.dart';

class ClubItemRentalStateBox extends StatelessWidget {
  final bool isRented;

  const ClubItemRentalStateBox({
    super.key,
    required this.isRented,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPaddingS - 8,
        vertical: defaultPaddingXS - 8,
      ),
      decoration: BoxDecoration(
        color: isRented ? context.colorScheme.primary : context.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(defaultBorderRadiusM / 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isRented ? Symbols.lock_clock_rounded : Symbols.lock_open_rounded,
            size: 16,
            color: isRented ? context.colorScheme.inversePrimary : context.colorScheme.outline,
          ),
          const Gap(defaultGapS),
          Text(
            isRented ? '대여 중' : '보관 중',
            style: (isRented ? context.textTheme.titleSmall : context.textTheme.bodyLarge)?.copyWith(
              color: isRented ? context.colorScheme.inversePrimary : context.colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}
