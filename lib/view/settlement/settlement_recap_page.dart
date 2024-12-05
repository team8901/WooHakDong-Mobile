import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../view_model/club/current_club_info_provider.dart';
import '../themes/spacing.dart';

class SettlementRecapPage extends ConsumerWidget {
  const SettlementRecapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentClubInfo = ref.watch(currentClubInfoProvider);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultPaddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('${currentClubInfo.clubName}', style: context.textTheme.headlineSmall),
                  DefaultTextStyle(
                    style: context.textTheme.headlineSmall!.copyWith(color: context.colorScheme.primary),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      pause: const Duration(milliseconds: 500),
                      animatedTexts: [
                        FadeAnimatedText('에 몇 명이나 가입했을까?'),
                        FadeAnimatedText('에서 가장 많이 대여한 물품은?'),
                        FadeAnimatedText('는 얼마나 썼을까?'),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(defaultGapXL),
              Text('기능 구현 중...', style: context.textTheme.bodyLarge),

              /// TODO: 통계 내용 추가하기
            ],
          ),
        ),
      ),
    );
  }
}
