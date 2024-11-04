import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
// ignore: implementation_imports
import 'package:widgets_to_png/src/entity/image_converter.dart';
import 'package:widgets_to_png/widgets_to_png.dart';
import 'package:woohakdong/model/group/group.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_loading_skeleton.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../repository/group/group_repository.dart';
import '../../service/general/general_functions.dart';
import '../../view_model/club/current_club_info_provider.dart';
import '../club_register/components/club_register_qr_card.dart';
import '../club_register/components/club_register_url_card.dart';
import '../themes/spacing.dart';

class ClubInfoPromotionPage extends ConsumerWidget {
  final GlobalKey _widgetToPngKey = GlobalKey();

  ClubInfoPromotionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentClubInfoId = ref.watch(currentClubInfoProvider).clubId;

    return Scaffold(
      appBar: AppBar(
        title: const Text('모집 정보'),
        actions: [
          IconButton(
            onPressed: () async {
              await ImageConverter.saveWidgetToGallery(
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
          child: FutureBuilder(
            future: GroupRepository().getClubRegisterPageInfo(currentClubInfoId!),
            builder: (context, groupInfoSnapshot) {
              final isLoading = groupInfoSnapshot.connectionState == ConnectionState.waiting;

              final groupInfo = isLoading ? _generateFakeGroupInfo() : groupInfoSnapshot.data;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${groupInfo?.groupName} 전용 페이지',
                    style: context.textTheme.titleMedium,
                  ),
                  const Gap(defaultGapM),
                  CustomLoadingSkeleton(
                    isLoading: isLoading,
                    ignoreContainers: false,
                    child: ClubRegisterUrlCard(groupInfo: groupInfo),
                  ),
                  const Gap(defaultGapM),
                  WidgetToPng(
                    keyToCapture: _widgetToPngKey,
                    child: CustomLoadingSkeleton(
                      isLoading: isLoading,
                      ignoreContainers: false,
                      child: ClubRegisterQrCard(groupInfo: groupInfo),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Group _generateFakeGroupInfo() {
    return Group(
      groupName: '우학동',
      groupJoinLink: 'https://www.woohakdong.com/clubs/woohakdong',
    );
  }
}
