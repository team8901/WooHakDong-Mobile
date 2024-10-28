import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/service/general/general_functions.dart';
import 'package:woohakdong/view/club_register/club_register_account_form_page.dart';
import 'package:woohakdong/view/themes/custom_widget/custom_info_box.dart';
import 'package:woohakdong/view/themes/custom_widget/custom_info_content.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../view_model/club/club_provider.dart';
import '../../view_model/club/components/club_state.dart';
import '../../view_model/club/components/club_state_provider.dart';
import '../../view_model/util/s3_image_provider.dart';
import '../themes/custom_widget/custom_bottom_button.dart';
import '../themes/spacing.dart';

class ClubRegisterInfoCheckPage extends ConsumerWidget {
  const ClubRegisterInfoCheckPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s3ImageState = ref.watch(s3ImageProvider);
    final s3ImageNotifier = ref.read(s3ImageProvider.notifier);
    final clubNotifier = ref.read(clubProvider.notifier);
    final clubInfo = ref.watch(clubProvider);
    final clubState = ref.watch(clubStateProvider);

    return Scaffold(
      appBar: AppBar(),
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
                  '한 번 더 확인해 주세요',
                  style: context.textTheme.headlineSmall,
                ),
                const Gap(defaultGapXL * 2),
                Text(
                  '동아리 사진',
                  style: context.textTheme.labelLarge,
                ),
                const Gap(defaultGapM),
                Container(
                  width: 192.r,
                  height: 192.r,
                  decoration: BoxDecoration(
                    border: Border.all(color: context.colorScheme.surfaceContainer),
                    borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                    child: Image.file(
                      s3ImageState.pickedImages[0],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                const Gap(defaultGapXL),
                CustomInfoBox(
                  infoTitle: '동아리 기본 정보',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomInfoContent(infoContent: clubInfo.clubName!),
                      const Gap(defaultGapM),
                      CustomInfoContent(infoContent: clubInfo.clubEnglishName!),
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
                    horizontal: defaultPaddingM,
                    vertical: defaultPaddingXS,
                  ),
                  child: CustomInfoContent(infoContent: clubInfo.clubDescription!),
                ),
                const Gap(defaultGapXL),
                CustomInfoBox(
                  infoTitle: '동아리 추가 정보',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (clubInfo.clubGeneration != '')
                          ? Column(
                              children: [
                                CustomInfoContent(infoContent: _generationFormatting(clubInfo.clubGeneration!)),
                                const Gap(defaultGapM),
                              ],
                            )
                          : const SizedBox(),
                      CustomInfoContent(infoContent: _currencyFormatting(clubInfo.clubDues!)),
                      (clubInfo.clubRoom != '')
                          ? Column(
                              children: [
                                const Gap(defaultGapM),
                                CustomInfoContent(infoContent: clubInfo.clubRoom!),
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
                      CustomInfoContent(infoContent: clubInfo.clubGroupChatLink!),
                      (clubInfo.clubGroupChatPassword != '')
                          ? Column(
                              children: [
                                const Gap(defaultGapXL),
                                CustomInfoContent(infoContent: clubInfo.clubGroupChatPassword!),
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
      bottomNavigationBar: SafeArea(
        child: CustomBottomButton(
          onTap: () async {
            try {
              List<String> imageUrls = await s3ImageNotifier.setImageUrl('1');
              final clubImageUrl = imageUrls.isNotEmpty ? imageUrls[0] : '';

              String clubImageForServer = clubImageUrl.substring(0, clubImageUrl.indexOf('?'));

              await clubNotifier.registerClub(clubImageForServer);

              if (context.mounted) {
                await _pushAccountFormPage(context);
              }
            } catch (e) {
              await GeneralFunctions.generalToastMessage('오류가 발생했어요\n다시 시도해 주세요');
            }
          },
          buttonText: '확인했어요',
          buttonColor: Theme.of(context).colorScheme.primary,
          buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
          isLoading: clubState == ClubState.loading,
        ),
      ),
    );
  }

  String _generationFormatting(String clubGeneration) {
    String formattedGeneration = '$clubGeneration 기';

    return formattedGeneration;
  }

  String _currencyFormatting(int clubDues) {
    String formattedDues = CurrencyFormatter.format(
      clubDues.toString(),
      const CurrencyFormat(
        symbol: '원',
        symbolSide: SymbolSide.right,
        decimalSeparator: ',',
      ),
    );

    return formattedDues;
  }

  Future<void> _pushAccountFormPage(BuildContext context) async {
    await Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
        builder: (context) => const ClubRegisterAccountFormPage(),
      ),
      (route) => false,
    );
  }
}
