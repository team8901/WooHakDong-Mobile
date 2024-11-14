import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/custom_widget/button/custom_info_tooltip.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../service/general/general_functions.dart';
import '../../view_model/club/current_club_info_provider.dart';
import '../themes/custom_widget/interface/custom_info_box.dart';
import '../themes/custom_widget/interface/custom_info_content.dart';
import '../themes/spacing.dart';
import 'club_info_edit_page.dart';

class ClubInfoDetailPage extends ConsumerWidget {
  const ClubInfoDetailPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentClubInfo = ref.watch(currentClubInfoProvider);
    final imageProvider = CachedNetworkImageProvider(currentClubInfo.clubImage!);

    return Scaffold(
      appBar: AppBar(
        title: const Text('동아리 정보'),
        actions: [
          IconButton(
            onPressed: () => _pushClubInfoEditPage(context),
            icon: const Icon(Symbols.border_color_rounded),
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
                '동아리 로고 및 대표 사진',
                style: context.textTheme.labelLarge,
              ),
              const Gap(defaultGapM),
              GestureDetector(
                onTap: () => GeneralFunctions.pushImageView(context, imageProvider),
                child: Center(
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
                        Symbols.attach_money_rounded,
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
                infoTitleIcon: const CustomInfoTooltip(
                  tooltipMessage: '카카오톡 채팅방 링크를 누르면 복사돼요',
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => GeneralFunctions.clipboardCopy(
                        currentClubInfo.clubGroupChatLink!,
                        '카카오톡 채팅방 링크가 복사되었어요',
                      ),
                      child: CustomInfoContent(
                        isUnderline: true,
                        infoContent: currentClubInfo.clubGroupChatLink!,
                        icon: Icon(
                          Symbols.forum_rounded,
                          size: 16,
                          color: context.colorScheme.outline,
                        ),
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
    );
  }

  void _pushClubInfoEditPage(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const ClubInfoEditPage(),
      ),
    );
  }
}
