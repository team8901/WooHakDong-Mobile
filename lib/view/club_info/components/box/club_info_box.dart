import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/model/club/current_club.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class ClubInfoBox extends ConsumerWidget {
  final CurrentClub currentClubInfo;
  final int clubMemberCount;
  final int itemCount;

  const ClubInfoBox({
    super.key,
    required this.currentClubInfo,
    required this.clubMemberCount,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPaddingM),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 72.r,
            height: 72.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: CachedNetworkImageProvider(currentClubInfo.clubImage!),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: context.colorScheme.surfaceContainer,
                width: 0.6,
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
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  currentClubInfo.clubEnglishName!,
                  style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                ),
                const Gap(defaultGapS / 4),
                Row(
                  children: [
                    const Icon(Symbols.group_rounded, size: 16),
                    const Gap(defaultGapS / 2),
                    Text(
                      clubMemberCount.toString(),
                      style: context.textTheme.bodySmall,
                    ),
                    const Gap(defaultGapS),
                    const Icon(Symbols.list_alt_rounded, size: 16),
                    const Gap(defaultGapS / 2),
                    Text(
                      itemCount.toString(),
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
