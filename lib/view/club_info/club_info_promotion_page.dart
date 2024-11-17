import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/group/group_provider.dart';

import '../../service/general/general_image.dart';
import '../../service/general/general_functions.dart';
import '../club_register/components/club_register_qr_card.dart';
import '../club_register/components/club_register_url_card.dart';
import '../themes/spacing.dart';

class ClubInfoPromotionPage extends ConsumerWidget {
  final GlobalKey _widgetToPngKey = GlobalKey();

  ClubInfoPromotionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupInfo = ref.watch(groupProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('모집 정보'),
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
                '${groupInfo.groupName} 전용 페이지',
                style: context.textTheme.titleMedium,
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
    );
  }
}
