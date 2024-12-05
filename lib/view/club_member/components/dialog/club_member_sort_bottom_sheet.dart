import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../../view_model/club_member/components/club_member_sort_option.dart';
import '../../../../view_model/club_member/components/club_member_sort_option_provider.dart';
import '../button/club_member_sort_bottom_sheet_button.dart';

class ClubMemberSortBottomSheet extends ConsumerWidget {
  const ClubMemberSortBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.2,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: defaultPaddingM),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPaddingM,
                vertical: defaultPaddingS / 2,
              ),
              child: Text(
                '회원 정렬',
                style: context.textTheme.titleLarge,
              ),
            ),
            const Gap(defaultGapS),
            ClubMemberSortBottomSheetButton(
              clubMemberSortOption: ClubMemberSortOption.oldest,
              displayText: '등록순',
              onTap: () => ref.read(clubMemberSortOptionProvider.notifier).state = ClubMemberSortOption.oldest,
            ),
            const Gap(defaultGapS),
            ClubMemberSortBottomSheetButton(
              clubMemberSortOption: ClubMemberSortOption.newest,
              displayText: '최신순',
              onTap: () => ref.read(clubMemberSortOptionProvider.notifier).state = ClubMemberSortOption.newest,
            ),
            const Gap(defaultGapS),
            ClubMemberSortBottomSheetButton(
              clubMemberSortOption: ClubMemberSortOption.nameAsc,
              displayText: '이름 오름차순',
              onTap: () => ref.read(clubMemberSortOptionProvider.notifier).state = ClubMemberSortOption.nameAsc,
            ),
            const Gap(defaultGapS),
            ClubMemberSortBottomSheetButton(
              clubMemberSortOption: ClubMemberSortOption.nameDesc,
              displayText: '이름 내림차순',
              onTap: () => ref.read(clubMemberSortOptionProvider.notifier).state = ClubMemberSortOption.nameDesc,
            ),
            const Gap(defaultGapXL),
          ],
        ),
      ),
    );
  }
}
