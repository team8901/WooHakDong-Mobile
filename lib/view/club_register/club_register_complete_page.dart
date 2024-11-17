import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../service/general/general_image.dart';
import '../../service/general/general_functions.dart';
import '../../view_model/group/group_provider.dart';
import '../themes/custom_widget/button/custom_bottom_button.dart';
import '../themes/custom_widget/interaction/custom_pop_scope.dart';
import '../themes/spacing.dart';
import 'components/club_register_qr_card.dart';
import 'components/club_register_url_card.dart';

class ClubRegisterCompletePage extends ConsumerWidget {
  final GlobalKey _widgetToPngKey = GlobalKey();

  ClubRegisterCompletePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupInfo = ref.watch(groupProvider);

    return CustomPopScope(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                await GeneralImage.convertWidgetToPng(
                  key: _widgetToPngKey,
                  fileName: '우학동 QR 카드 ${DateTime.now().millisecondsSinceEpoch}.png',
                );
                await GeneralFunctions.toastMessage('QR 카드 이미지를 저장했어요');
              },
              icon: const Icon(Symbols.download_rounded),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(defaultPaddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '동아리가 등록되었어요! 🎉',
                  style: context.textTheme.headlineLarge?.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
                const Gap(defaultGapXL * 2),
                Text(
                  '${groupInfo.groupName} 전용 페이지',
                  style: context.textTheme.titleMedium,
                ),
                Text(
                  '동아리 회원 가입 및 동아리 서비스 이용이 가능해요',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
                const Gap(defaultGapM),
                ClubRegisterUrlCard(groupInfo: groupInfo),
                const Gap(defaultGapM),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                    border: Border.all(color: context.colorScheme.surfaceContainer),
                  ),
                  padding: const EdgeInsets.all(defaultPaddingS / 2),
                  child: RepaintBoundary(
                    key: _widgetToPngKey,
                    child: ClubRegisterQrCard(groupInfo: groupInfo),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: CustomBottomButton(
            onTap: () async => await Phoenix.rebirth(context),
            buttonText: '내 동아리 확인하기',
            buttonColor: Theme.of(context).colorScheme.primary,
            buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
    );
  }
}
