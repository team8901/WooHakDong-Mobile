import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../model/club/club.dart';
import '../../service/general/general_functions.dart';
import '../themes/custom_widget/interface/custom_info_box.dart';
import '../themes/custom_widget/interface/custom_info_content.dart';
import '../themes/spacing.dart';

class ClubInfoDetailPage extends StatelessWidget {
  final Club currentClubInfo;

  const ClubInfoDetailPage({
    super.key,
    required this.currentClubInfo,
  });

  @override
  Widget build(BuildContext context) {
    final imageProvider = CachedNetworkImageProvider(currentClubInfo.clubImage!);

    return Scaffold(
      appBar: AppBar(
        title: const Text('상세 정보'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.all(defaultPaddingM),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '동아리 로고 및 대표 사진',
                  style: context.textTheme.labelLarge,
                ),
                const Gap(defaultGapM),
                Center(
                  child: Container(
                    width: 192.r,
                    height: 192.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: context.colorScheme.surfaceContainer),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Gap(defaultGapXL),
                CustomInfoBox(
                  infoTitle: '동아리 기본 정보',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomInfoContent(
                        infoContent: currentClubInfo.clubName!,
                        icon: Icon(
                          Symbols.account_balance_rounded,
                          size: 16,
                          color: context.colorScheme.outline,
                        ),
                      ),
                      const Gap(defaultGapM),
                      CustomInfoContent(
                        infoContent: currentClubInfo.clubEnglishName!,
                        icon: Icon(
                          Symbols.signature_rounded,
                          size: 16,
                          color: context.colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(defaultGapM),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: context.colorScheme.surfaceContainer),
                    borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultPaddingS,
                    vertical: defaultPaddingXS,
                  ),
                  child: CustomInfoContent(
                    infoContent: currentClubInfo.clubDescription!,
                    icon: Icon(
                      Symbols.info_rounded,
                      size: 16,
                      color: context.colorScheme.outline,
                    ),
                  ),
                ),
                const Gap(defaultGapXL),
                CustomInfoBox(
                  infoTitle: '동아리 추가 정보',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (currentClubInfo.clubGeneration != '')
                          ? Column(
                              children: [
                                CustomInfoContent(
                                  infoContent: GeneralFunctions.formatClubGeneration(currentClubInfo.clubGeneration!),
                                  icon: Icon(
                                    Symbols.numbers_rounded,
                                    size: 16,
                                    color: context.colorScheme.outline,
                                  ),
                                ),
                                const Gap(defaultGapM),
                              ],
                            )
                          : const SizedBox(),
                      CustomInfoContent(
                        infoContent: GeneralFunctions.formatClubDues(currentClubInfo.clubDues!),
                        icon: Icon(
                          Symbols.payment_rounded,
                          size: 16,
                          color: context.colorScheme.outline,
                        ),
                      ),
                      (currentClubInfo.clubRoom != '')
                          ? Column(
                              children: [
                                const Gap(defaultGapM),
                                CustomInfoContent(
                                  infoContent: currentClubInfo.clubRoom!,
                                  icon: Icon(
                                    Symbols.location_on_rounded,
                                    size: 16,
                                    color: context.colorScheme.outline,
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                const Gap(defaultGapXL),
                CustomInfoBox(
                  infoTitle: '카카오톡 채팅방',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomInfoContent(
                        infoContent: currentClubInfo.clubGroupChatLink!,
                        icon: Icon(
                          Symbols.forum_rounded,
                          size: 16,
                          color: context.colorScheme.outline,
                        ),
                      ),
                      (currentClubInfo.clubGroupChatPassword != '')
                          ? Column(
                              children: [
                                const Gap(defaultGapXL),
                                CustomInfoContent(
                                  infoContent: currentClubInfo.clubGroupChatPassword!,
                                  icon: Icon(
                                    Symbols.key_rounded,
                                    size: 16,
                                    color: context.colorScheme.outline,
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
