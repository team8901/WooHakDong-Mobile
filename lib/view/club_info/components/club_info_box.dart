import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/model/club/club.dart';
import 'package:woohakdong/view/club_info/club_info_detail_page.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class ClubInfoBox extends ConsumerWidget {
  final Club currentClubInfo;

  const ClubInfoBox({
    super.key,
    required this.currentClubInfo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageProvider = CachedNetworkImageProvider(currentClubInfo.clubImage!);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 72.r,
          height: 72.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
            border: Border.all(
              color: context.colorScheme.surfaceContainer,
              width: 1,
            ),
          ),
        ),
        const Gap(defaultGapM),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentClubInfo.clubName!,
                style: context.textTheme.titleSmall,
              ),
              const Gap(defaultGapS / 4),
              Text(
                currentClubInfo.clubEnglishName!,
                style: context.textTheme.bodySmall,
              ),
            ],
          ),
        ),
        const Gap(defaultGapM),
        InkWell(
          onTap: () => _pushClubInfoDetailPage(context, currentClubInfo),
          borderRadius: BorderRadius.circular(defaultBorderRadiusM / 2),
          child: Ink(
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(defaultBorderRadiusM / 2),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPaddingS - 8,
              vertical: defaultPaddingXS - 8,
            ),
            child: Text(
              '상세 정보',
              style: context.textTheme.labelLarge,
            ),
          ),
        ),
      ],
    );
  }

  void _pushClubInfoDetailPage(BuildContext context, Club currentClubInfo) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ClubInfoDetailPage(currentClubInfo: currentClubInfo),
      ),
    );
  }
}
