import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../view_model/group/group_provider.dart';
import '../themes/custom_widget/custom_bottom_button.dart';
import '../themes/spacing.dart';

class ClubRegisterCompletePage extends ConsumerWidget {
  const ClubRegisterCompletePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupInfo = ref.watch(groupProvider);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPaddingM,
            vertical: defaultPaddingM,
          ),
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
              Container(
                width: double.infinity,
                height: 192.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                  border: Border.all(color: context.colorScheme.surfaceContainer),
                ),
                padding: const EdgeInsets.all(defaultPaddingS),
                child: QrImageView(
                  data: '${groupInfo?.groupLink}',
                  version: QrVersions.auto,
                  size: 160.h,
                  padding: EdgeInsets.zero,
                  eyeStyle: QrEyeStyle(
                    eyeShape: QrEyeShape.circle,
                    color: context.colorScheme.inverseSurface,
                  ),
                  dataModuleStyle: QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.circle,
                    color: context.colorScheme.inverseSurface,
                  ),
                ),
              ),
              const Gap(defaultGapS),
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
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${groupInfo?.groupLink}',
                          style: context.textTheme.titleSmall,
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      const Gap(defaultGapL),
                      InkWell(
                        onTap: () async {
                          Clipboard.setData(ClipboardData(text: '${groupInfo?.groupLink}'));
                          await Fluttertoast.showToast(
                            msg: '전용 페이지 링크가 복사되었어요',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            gravity: ToastGravity.CENTER,
                            textColor: context.colorScheme.inverseSurface,
                            backgroundColor: context.colorScheme.surfaceContainer.withOpacity(0.9),
                            fontSize: 16,
                            fontAsset: 'Pretendard',
                          );
                        },
                        child: Ink(
                          child: Icon(
                            Icons.copy_rounded,
                            color: context.colorScheme.onSurface,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: CustomBottomButton(
          onTap: () => {},
          buttonText: '우학동 시작하기',
          buttonColor: Theme.of(context).colorScheme.primary,
          buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}
