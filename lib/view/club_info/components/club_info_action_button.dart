import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_tap_debouncer.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../view/themes/spacing.dart';

class ClubInfoActionButton extends ConsumerWidget {
  final VoidCallback onTapDetail;
  final Future<void> Function() onTapPromotion;

  const ClubInfoActionButton({
    super.key,
    required this.onTapDetail,
    required this.onTapPromotion,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPaddingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              onTap: onTapDetail,
              splashColor: context.colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(defaultBorderRadiusM),
              highlightColor: context.colorScheme.surfaceContainer,
              child: Ink(
                decoration: BoxDecoration(
                  border: Border.all(color: context.colorScheme.surfaceContainer),
                  borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPaddingS,
                  vertical: defaultPaddingXS,
                ),
                child: Center(
                  child: Text(
                    '동아리 정보',
                    style: context.textTheme.bodySmall,
                  ),
                ),
              ),
            ),
          ),
          const Gap(defaultGapM),
          CustomTapDebouncer(
            onTap: onTapPromotion,
            builder: (context, onTap) {
              return Expanded(
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                  splashColor: context.colorScheme.surfaceContainer,
                  highlightColor: context.colorScheme.surfaceContainer,
                  child: Ink(
                    decoration: BoxDecoration(
                      border: Border.all(color: context.colorScheme.surfaceContainer),
                      borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPaddingS,
                      vertical: defaultPaddingXS,
                    ),
                    child: Center(
                      child: Text(
                        '모집 정보',
                        style: context.textTheme.bodySmall,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
