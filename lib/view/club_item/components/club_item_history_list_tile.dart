import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:woohakdong/model/item/item_history.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../themes/spacing.dart';

class ClubItemHistoryListTile extends StatelessWidget {
  final ItemHistory itemHistory;

  const ClubItemHistoryListTile({
    super.key,
    required this.itemHistory,
  });

  @override
  Widget build(BuildContext context) {
    final imageProvider = (itemHistory.itemReturnImage != null && itemHistory.itemReturnImage!.isNotEmpty)
        ? CachedNetworkImageProvider(itemHistory.itemReturnImage!)
        : const AssetImage('assets/images/club/club_basic_image.jpg') as ImageProvider;

    return Padding(
      padding: const EdgeInsets.all(defaultPaddingM),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
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
          const Gap(defaultGapM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemHistory.memberName!,
                  style: context.textTheme.bodyLarge,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(defaultGapS / 2),
                Row(
                  children: [
                    Skeleton.shade(
                      child: Icon(
                        Symbols.output_rounded,
                        size: 16,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    const Gap(defaultGapS / 4),
                    Text(
                      _formatRentalDate(itemHistory.itemRentalDate),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                const Gap(defaultGapS / 4),
                Row(
                  children: [
                    Skeleton.shade(
                      child: Icon(
                        Symbols.input_rounded,
                        size: 16,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    const Gap(defaultGapS / 4),
                    Text(
                      (itemHistory.itemReturnDate == null)
                          ? '아직 반납하지 않았어요'
                          : _formatRentalDate(itemHistory.itemReturnDate),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
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

  String _formatRentalDate(DateTime? itemRentalDate) {
    String dateString = itemRentalDate.toString();
    DateTime dateTime = DateTime.parse(dateString).toLocal();
    int currentYear = DateTime.now().year;
    bool isCurrentYear = dateTime.year == currentYear;
    String dateFormat = isCurrentYear ? 'M월 d일, H:mm a' : 'yyyy년 M월 d일, H:mm a';

    return DateFormat(dateFormat).format(dateTime);
  }
}
