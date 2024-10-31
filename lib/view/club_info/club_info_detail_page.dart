import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../model/club/club.dart';
import '../../service/general/general_functions.dart';
import '../../view_model/club/current_club_provider.dart';
import '../themes/custom_widget/interface/cujstom_photo_view.dart';
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
    final currentClubInfo = ref.watch(currentClubProvider);
    final imageProvider = CachedNetworkImageProvider(currentClubInfo!.clubImage!);

    return Scaffold(
      appBar: AppBar(
        title: const Text('동아리 정보'),
        actions: [
          IconButton(
            onPressed: () => _pushClubInfoEditPage(context, currentClubInfo),
            icon: const Icon(Symbols.border_color_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                GestureDetector(
                  onTap: () => _pushItemPhotoView(context, imageProvider),
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

  void _pushItemPhotoView(BuildContext context, CachedNetworkImageProvider itemPhoto) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => CustomPhotoView(image: itemPhoto),
        transitionDuration: const Duration(milliseconds: 150),
        reverseTransitionDuration: const Duration(milliseconds: 150),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var curve = CurvedAnimation(
            parent: animation,
            curve: Curves.fastOutSlowIn,
            reverseCurve: Curves.fastOutSlowIn,
          );
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(curve),
            child: child,
          );
        },
      ),
    );
  }

  void _pushClubInfoEditPage(BuildContext context, Club currentClubInfo) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ClubInfoEditPage(currentClubInfo: currentClubInfo),
      ),
    );
  }
}
