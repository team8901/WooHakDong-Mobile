import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:woohakdong/model/item/item_history.dart';
import 'package:woohakdong/service/general/general_functions.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../themes/spacing.dart';

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
          GestureDetector(
            onTap: () {
              if (itemHistory.itemReturnImage == null || itemHistory.itemReturnImage!.isEmpty) {
                GeneralFunctions.toastMessage('아직 반납 사진이 없어요');
                return;
              }

              CachedNetworkImageProvider itemReturnImage = CachedNetworkImageProvider(itemHistory.itemReturnImage!);
              GeneralFunctions.pushImageView(context, itemReturnImage);
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
                    Icon(
                      Symbols.output_rounded,
                      size: 16,
                      color: context.colorScheme.onSurface,
                    ),
                    const Gap(defaultGapS / 4),
                    Text(
                      GeneralFunctions.formatDateTime(itemHistory.itemRentalDate),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                const Gap(defaultGapS / 4),
                Row(
                  children: [
                    Icon(
                      Symbols.input_rounded,
                      size: 16,
                      color: (itemHistory.itemReturnDate == null)
                          ? context.colorScheme.primary
                          : context.colorScheme.onSurface,
                    ),
                    const Gap(defaultGapS / 4),
                    Text(
                      (itemHistory.itemReturnDate == null)
                          ? '대여 중'
                          : GeneralFunctions.formatDateTime(itemHistory.itemReturnDate),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: (itemHistory.itemReturnDate == null)
                            ? context.colorScheme.primary
                            : context.colorScheme.onSurface,
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
}
