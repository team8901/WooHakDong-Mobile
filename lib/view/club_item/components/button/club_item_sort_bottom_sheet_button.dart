import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/model/item/item_filter.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/item/components/item_filter_provider.dart';
import 'package:woohakdong/view_model/item/components/item_sort.dart';

import '../../../../service/general/general_functions.dart';

class ClubItemSortBottomSheetButton extends ConsumerWidget {
  final ItemFilter filter;
  final ItemSortOption sortOption;
  final String displayText;
  final VoidCallback onTap;

  const ClubItemSortBottomSheetButton({
    super.key,
    required this.filter,
    required this.sortOption,
    required this.displayText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        onTap();
        Navigator.pop(context);
        GeneralFunctions.toastMessage('${sortOption.displayText}으로 정렬했어요');
      },
      highlightColor: context.colorScheme.surfaceContainer,
      child: Ink(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPaddingM,
          vertical: defaultPaddingM / 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              displayText,
              style: context.textTheme.bodyLarge,
            ),
            if (filter.itemSortOption == sortOption)
              Icon(
                size: 18,
                Symbols.check_circle_rounded,
                color: context.colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }
}
