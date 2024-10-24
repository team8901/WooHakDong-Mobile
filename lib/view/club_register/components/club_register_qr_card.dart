import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../model/group/group.dart';
import '../../themes/spacing.dart';

class ClubRegisterQrCard extends StatelessWidget {
  const ClubRegisterQrCard({
    super.key,
    required this.groupInfo,
  });

  final Group? groupInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceDim,
        borderRadius: BorderRadius.circular(defaultBorderRadiusM),
        border: Border.all(color: context.colorScheme.surfaceContainer),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: defaultPaddingS * 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: defaultPaddingS * 2),
            child: Text(
              '${groupInfo?.groupName}',
              style: context.textTheme.headlineLarge?.copyWith(
                fontSize: 28,
                color: context.colorScheme.primary,
              ),
            ),
          ),
          const Gap(defaultGapL * 2),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultBorderRadiusL),
              border: Border.all(color: context.colorScheme.primary, width: 5),
            ),
            padding: const EdgeInsets.all(defaultPaddingS),
            margin: const EdgeInsets.symmetric(horizontal: defaultPaddingM * 3),
            child: QrImageView(
              data: '${groupInfo?.groupJoinLink}',
              version: QrVersions.auto,
              padding: EdgeInsets.zero,
              eyeStyle: QrEyeStyle(
                eyeShape: QrEyeShape.square,
                color: context.colorScheme.inverseSurface,
              ),
              dataModuleStyle: QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.square,
                color: context.colorScheme.inverseSurface,
              ),
            ),
          ),
          const Gap(defaultGapL * 2),
          Text(
            'QR 코드를 스캔하면\n동아리 전용 페이지로 이동해요!',
            style: context.textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          const Gap(defaultGapL * 2),
          Text(
            '우학동 제공',
            style: context.textTheme.labelLarge?.copyWith(color: context.colorScheme.onSurface),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
