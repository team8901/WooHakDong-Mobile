import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/club_info/club_info_detail_page.dart';
import 'package:woohakdong/view/club_info/club_info_promotion_page.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_tap_debouncer.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/group/group_provider.dart';

import '../../../view/themes/spacing.dart';

class ClubInfoActionButton extends ConsumerWidget {
  const ClubInfoActionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: InkWell(
            onTap: () => _pushClubInfoDetailPage(context),
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
          onTap: () async => _pushClubPromotionPage(ref, context),
          builder: (context, onTap) {
            return Expanded(
              child: InkWell(
                onTap: onTap,
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
    );
  }

  void _pushClubInfoDetailPage(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const ClubInfoDetailPage(),
      ),
    );
  }

  Future<void> _pushClubPromotionPage(WidgetRef ref, BuildContext context) async {
    await ref.read(groupProvider.notifier).getClubRegisterPageInfo();

    if (context.mounted) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => ClubInfoPromotionPage(),
        ),
      );
    }
  }
}
