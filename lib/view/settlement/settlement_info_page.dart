import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/service/general/general_format.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../view_model/club/current_club_info_provider.dart';
import '../themes/custom_widget/button/custom_bottom_button.dart';
import '../themes/spacing.dart';

class SettlementInfoPage extends ConsumerWidget {
  const SettlementInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentClubInfo = ref.watch(currentClubInfoProvider);

    return Scaffold(
      appBar: AppBar(),
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
              Text(
                '지난 학기 ${currentClubInfo.clubName}의 이용료는',
                style: context.textTheme.headlineLarge,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: GeneralFormat.formatClubDues(100000),
                      style: context.textTheme.headlineLarge?.copyWith(color: context.colorScheme.primary),
                    ),
                    TextSpan(text: '이에요', style: context.textTheme.headlineLarge),
                  ],
                ),
              ),
              const Gap(defaultGapS / 2),
              Text(
                '기본 이용료 3만원에 회원 당 500원이 추가된 금액이에요',
                style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onSurface),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: CustomBottomButton(
          onTap: () => {},
          buttonText: '결제하기',
          buttonColor: Theme.of(context).colorScheme.primary,
          buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}
