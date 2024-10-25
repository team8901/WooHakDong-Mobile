import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:widgets_to_png/src/entity/image_converter.dart';
import 'package:widgets_to_png/widgets_to_png.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../service/general/general_functions.dart';
import '../../view_model/club/club_id_provider.dart';
import '../../view_model/club/club_list_provider.dart';
import '../../view_model/club/club_provider.dart';
import '../../view_model/group/group_provider.dart';
import '../route_page.dart';
import '../themes/custom_widget/custom_bottom_button.dart';
import '../themes/spacing.dart';
import 'components/club_register_qr_card.dart';
import 'components/club_register_url_card.dart';

class ClubRegisterCompletePage extends ConsumerWidget {
  final GlobalKey _widgetToPngKey = GlobalKey();

  ClubRegisterCompletePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupInfo = ref.watch(groupProvider);
    final clubInfo = ref.watch(clubProvider);
    DateTime? currentBackPressTime;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, dynamic) {
        final now = DateTime.now();

        if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 1)) {
          currentBackPressTime = now;

          GeneralFunctions.generalToastMessage("한 번 더 누르면 앱이 종료돼요");

          return;
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                await ImageConverter.saveWidgetToGallery(
                  key: _widgetToPngKey,
                  fileName: '${groupInfo?.groupName} QR 카드 ${DateTime.now().millisecondsSinceEpoch}.png',
                );
                await GeneralFunctions.generalToastMessage('QR 카드 이미지를 저장했어요');
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
                  '${groupInfo?.groupName} 전용 페이지',
                  style: context.textTheme.titleMedium,
                ),
                Text(
                  '동아리 회원 가입 및 동아리 서비스 이용이 가능해요',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
                const Gap(defaultGapS),
                ClubRegisterUrlCard(groupInfo: groupInfo),
                const Gap(defaultGapS),
                WidgetToPng(
                  keyToCapture: _widgetToPngKey,
                  child: ClubRegisterQrCard(groupInfo: groupInfo),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: CustomBottomButton(
            onTap: () async {
              await ref.read(clubIdProvider.notifier).saveClubId(clubInfo.clubId!);

              ref.invalidate(clubListProvider);

              if (context.mounted) {
                _pushRoutePage(context);
              }
            },
            buttonText: '내 동아리 확인하기',
            buttonColor: Theme.of(context).colorScheme.primary,
            buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
    );
  }

  void _pushRoutePage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
        builder: (context) => const RoutePage(),
      ),
      (route) => false,
    );
  }
}
