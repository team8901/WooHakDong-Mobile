import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:woohakdong/model/item/item_history.dart';
import 'package:woohakdong/service/general/general_functions.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../themes/spacing.dart';

class ClubMemberItemHistoryListTile extends StatelessWidget {
  final ItemHistory clubMemberItemHistory;
  final Future<void> Function()? onTap;

  const ClubMemberItemHistoryListTile({
    super.key,
    required this.clubMemberItemHistory,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final imageProvider = (clubMemberItemHistory.itemReturnImage?.isNotEmpty ?? false)
        ? CachedNetworkImageProvider(clubMemberItemHistory.itemReturnImage!)
        : const AssetImage('assets/images/club/club_basic_image.jpg') as ImageProvider;

    return Padding(
      padding: const EdgeInsets.all(defaultPaddingM),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              if (clubMemberItemHistory.itemReturnImage?.isEmpty ?? true) {
                GeneralFunctions.toastMessage('아직 반납 사진이 없어요');
              } else {
                final itemReturnImage = CachedNetworkImageProvider(clubMemberItemHistory.itemReturnImage!);
                GeneralFunctions.pushImageView(context, itemReturnImage);
              }
            },
            child: Container(
              width: 72.r,
              height: 72.r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultBorderRadiusM),
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
          ),
          const Gap(defaultGapM),
          Expanded(
            child: InkWell(
              onTap: onTap,
              highlightColor: context.colorScheme.surfaceContainer,
              child: Ink(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      clubMemberItemHistory.itemName ?? '',
                      style: context.textTheme.bodyLarge,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(defaultGapS / 2),
                    Row(
                      children: [
                        Icon(
                          Symbols.output_rounded,
                          size: 16,
                          color: context.colorScheme.onSurface,
                        ),
                        const Gap(defaultGapS / 2),
                        Text(
                          GeneralFunctions.formatDateTime(clubMemberItemHistory.itemRentalDate),
                          style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                        ),
                      ],
                    ),
                    const Gap(defaultGapS / 4),
                    Row(
                      children: [
                        Icon(
                          clubMemberItemHistory.itemReturnDate != null
                              ? Symbols.input_rounded
                              : (clubMemberItemHistory.itemOverdue!)
                                  ? Symbols.priority_high_rounded
                                  : Symbols.lock_clock_rounded,
                          size: 16,
                          color: clubMemberItemHistory.itemReturnDate != null
                              ? context.colorScheme.onSurface
                              : (clubMemberItemHistory.itemOverdue!)
                                  ? context.colorScheme.error
                                  : context.colorScheme.primary,
                        ),
                        const Gap(defaultGapS / 2),
                        Text(
                          clubMemberItemHistory.itemReturnDate != null
                              ? GeneralFunctions.formatDateTime(clubMemberItemHistory.itemReturnDate!)
                              : (clubMemberItemHistory.itemOverdue!)
                                  ? '연체됨'
                                  : '대여 중',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: clubMemberItemHistory.itemReturnDate != null
                                ? context.colorScheme.onSurface
                                : (clubMemberItemHistory.itemOverdue!)
                                    ? context.colorScheme.error
                                    : context.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
