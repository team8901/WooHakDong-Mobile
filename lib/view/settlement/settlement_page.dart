import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/settlement/settlement_info_page.dart';
import 'package:woohakdong/view/settlement/settlement_recap_page.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_pop_scope.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/member/member_provider.dart';

import '../../view_model/club/club_list_provider.dart';
import '../../view_model/club/current_club_info_provider.dart';
import '../club_info/components/club_info_bottom_sheet.dart';
import '../themes/custom_widget/button/custom_bottom_button.dart';
import '../themes/spacing.dart';

class SettlementPage extends ConsumerWidget {
  const SettlementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberInfo = ref.watch(memberProvider);
    final currentClubInfo = ref.watch(currentClubInfoProvider);

    return CustomPopScope(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => showModalBottomSheet(
                useSafeArea: true,
                context: context,
                builder: (context) => ClubInfoBottomSheet(
                  currentClubId: currentClubInfo.clubId!,
                  clubList: ref.watch(clubListProvider),
                ),
              ),
              icon: const Icon(Symbols.list_rounded),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: defaultPaddingM * 3,
              left: defaultPaddingM,
              right: defaultPaddingM,
              bottom: defaultPaddingM,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: currentClubInfo.clubName,
                        style: context.textTheme.headlineLarge?.copyWith(
                          color: context.colorScheme.primary,
                        ),
                      ),
                      TextSpan(
                        text: ' ${memberInfo!.memberName} 회장님',
                        style: context.textTheme.headlineLarge,
                      ),
                    ],
                  ),
                ),
                Text(
                  '우학동을 사용해 주셔서 감사해요 🤗',
                  style: context.textTheme.headlineLarge,
                ),
                const Gap(defaultGapS / 2),
                Text(
                  '이번 학기에도 우학동을 사용하려면 이용료를 결제해야 해요',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
                const Gap(defaultGapXL * 2),
                Text(
                  '지난 학기 ${currentClubInfo.clubName}의 Recap도 확인해 보세요!',
                  style: context.textTheme.bodyLarge,
                ),
                const Gap(defaultGapM),
                InkWell(
                  onTap: () => _pushSettlementRecapPage(context),
                  highlightColor: context.colorScheme.outline,
                  borderRadius: BorderRadius.circular(defaultBorderRadiusL),
                  child: Ink(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPaddingS,
                      vertical: defaultPaddingXS,
                    ),
                    decoration: BoxDecoration(
                      color: context.colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(defaultBorderRadiusL),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Symbols.play_circle_rounded, size: 16),
                        const Gap(defaultGapS / 2),
                        Text('Recap 보러가기', style: context.textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: CustomBottomButton(
            onTap: () => _pushSettlementInfoPage(context),
            buttonText: '다음',
            buttonColor: Theme.of(context).colorScheme.primary,
            buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
    );
  }

  void _pushSettlementRecapPage(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const SettlementRecapPage(),
      ),
    );
  }

  void _pushSettlementInfoPage(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const SettlementInfoPage(),
      ),
    );
  }
}
