import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/club_info/club_info_promotion_page.dart';
import 'package:woohakdong/view/club_info/components/club_info_box.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../model/club/club.dart';
import '../../view_model/auth/auth_provider.dart';
import '../../view_model/club/current_club_provider.dart';
import '../themes/spacing.dart';
import 'components/club_info_bottom_sheet.dart';

class ClubInfoPage extends ConsumerWidget {
  const ClubInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentClubInfo = ref.watch(currentClubProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            showModalBottomSheet(
              useSafeArea: true,
              context: context,
              builder: (context) {
                return const ClubInfoBottomSheet();
              },
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: Text(currentClubInfo?.clubName ?? '내 동아리', softWrap: false)),
              const Gap(defaultGapS),
              const Icon(
                Symbols.keyboard_arrow_down_rounded,
                size: 20,
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              authNotifier.signOut();
            },
            icon: const Icon(Symbols.settings_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.all(defaultPaddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClubInfoBox(currentClubInfo: currentClubInfo!),
              const Gap(defaultGapXL),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      /// TODO 동아리 정보 수정 추가하기
                      onTap: () {},
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Symbols.edit_rounded,
                                size: 16,
                                color: context.colorScheme.onSurface,
                              ),
                              const Gap(defaultGapS),
                              Flexible(
                                child: Text(
                                  '정보 수정',
                                  style: context.textTheme.bodySmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(defaultGapM),
                  Expanded(
                    child: InkWell(
                      onTap: () => _pushClubPromotionPage(context, currentClubInfo),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Symbols.qr_code_2_rounded,
                              size: 16,
                              color: context.colorScheme.onSurface,
                            ),
                            const Gap(defaultGapS),
                            Flexible(
                              child: Text(
                                '모집 정보',
                                style: context.textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pushClubPromotionPage(BuildContext context, Club currentClubInfo) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ClubInfoPromotionPage(currentClubInfo: currentClubInfo),
      ),
    );
  }
}
