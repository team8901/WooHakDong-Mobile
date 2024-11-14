import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/model/club/club.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../themes/spacing.dart';

class ClubInfoListListTile extends ConsumerWidget {
  final Club club;
  final bool isCurrent;
  final VoidCallback onTap;

  const ClubInfoListListTile({
    super.key,
    required this.club,
    required this.isCurrent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageProvider = (club.clubImage != null && club.clubImage!.isNotEmpty)
        ? CachedNetworkImageProvider(club.clubImage!)
        : const AssetImage('assets/images/club/club_basic_image.jpg') as ImageProvider;

    return InkWell(
      onTap: onTap,
      highlightColor: context.colorScheme.onInverseSurface,
      child: Ink(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPaddingM,
            vertical: defaultPaddingS / 2,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.colorScheme.onInverseSurface,
                  ),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(defaultGapXL),
              Expanded(
                child: Text(
                  club.clubName!,
                  style: context.textTheme.bodyLarge,
                  softWrap: true,
                ),
              ),
              const Gap(defaultGapXL),
              if (isCurrent)
                Icon(
                  size: 20,
                  Symbols.check_circle_rounded,
                  fill: 1,
                  color: context.colorScheme.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
