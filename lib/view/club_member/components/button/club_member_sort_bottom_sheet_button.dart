import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/club_member/components/club_member_sort_option.dart';

import '../../../../service/general/general_functions.dart';
import '../../../../view_model/club_member/components/club_member_sort_option_provider.dart';

class ClubMemberSortBottomSheetButton extends ConsumerWidget {
  final ClubMemberSortOption clubMemberSortOption;
  final String displayText;
  final VoidCallback onTap;

  const ClubMemberSortBottomSheetButton({
    super.key,
    required this.clubMemberSortOption,
    required this.displayText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        onTap();
        Navigator.pop(context);
        GeneralFunctions.toastMessage('${clubMemberSortOption.displayText}으로 정렬했어요');
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
            if (ref.watch(clubMemberSortOptionProvider) == clubMemberSortOption)
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
