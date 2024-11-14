import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/service/general/general_functions.dart';
import 'package:woohakdong/view/club_item/components/club_item_rental_state_box.dart';
import 'package:woohakdong/view/themes/custom_widget/interface/custom_info_box.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../model/item/item.dart';
import '../../themes/custom_widget/interface/custom_info_content.dart';
import '../../themes/spacing.dart';

class ClubItemInfoBox extends StatelessWidget {
  const ClubItemInfoBox({
    super.key,
    required this.itemInfo,
  });

  final Item itemInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPaddingM),
      child: Column(
        children: [
          Center(
            child: Text(
              GeneralFunctions.formatItemCategory(itemInfo.itemCategory!),
              style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onSurface),
            ),
          ),
          const Gap(defaultGapS),
          Center(
            child: Text(
              itemInfo.itemName!,
              style: context.textTheme.titleLarge,
            ),
          ),
          if (itemInfo.itemAvailable != null && !itemInfo.itemAvailable!)
            Column(
              children: [
                const Gap(defaultGapS),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultPaddingS - 8,
                    vertical: defaultPaddingXS - 8,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorScheme.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(defaultBorderRadiusM / 2),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Symbols.block_rounded,
                        size: 16,
                        color: context.colorScheme.error,
                      ),
                      const Gap(defaultGapS),
                      Text(
                        '대여 불가',
                        style: context.textTheme.titleSmall?.copyWith(
                          color: context.colorScheme.error,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          const Gap(defaultGapS),
          ClubItemRentalStateBox(isRented: itemInfo.itemUsing!),
          const Gap(defaultGapXL * 2),
          CustomInfoBox(
            infoTitle: '물품 설명',
            child: CustomInfoContent(
              infoContent: itemInfo.itemDescription!,
              icon: Icon(
                Symbols.info_rounded,
                size: 16,
                color: context.colorScheme.outline,
              ),
            ),
          ),
          const Gap(defaultGapXL),
          CustomInfoBox(
            infoTitle: '물품 추가 정보',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomInfoContent(
                  infoContent: itemInfo.itemLocation!,
                  icon: Icon(
                    Symbols.pin_drop_rounded,
                    size: 16,
                    color: context.colorScheme.outline,
                  ),
                ),
                const Gap(defaultGapM),
                CustomInfoContent(
                  infoContent: '${itemInfo.itemRentalMaxDay!.toString()}일 대여 가능',
                  icon: Icon(
                    Symbols.hourglass_rounded,
                    size: 16,
                    color: context.colorScheme.outline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
