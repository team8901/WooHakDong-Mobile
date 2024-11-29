import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../view_model/club/club_list_provider.dart';
import '../../../view_model/club/current_club_info_provider.dart';
import '../../club_info/components/club_info_bottom_sheet.dart';
import '../../themes/custom_widget/interaction/custom_pop_scope.dart';
import '../../themes/spacing.dart';

class ClubRegisterAccountPageWhenMemberOrSecretary extends ConsumerWidget {
  const ClubRegisterAccountPageWhenMemberOrSecretary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentClubInfo = ref.watch(currentClubInfoProvider);

    return CustomPopScope(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => showModalBottomSheet(
                useSafeArea: true,
                context: context,
                builder: (context) => ClubInfoBottomSheet(
                  currentClubId: currentClubInfo.clubId!,
                  clubList: ref.watch(clubListProvider),
                ),
              ),
              icon: const Icon(Symbols.list_rounded),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: defaultPaddingM * 3,
              left: defaultPaddingM,
              right: defaultPaddingM,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentClubInfo.clubName ?? '',
                  style: context.textTheme.headlineLarge?.copyWith(color: context.colorScheme.primary),
                ),
                Text(
                  '동아리 회비 계좌가 등록되지 않았어요',
                  style: context.textTheme.headlineLarge,
                ),
                Text(
                  '회장님께 계좌 등록을 요청해 보세요!',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
