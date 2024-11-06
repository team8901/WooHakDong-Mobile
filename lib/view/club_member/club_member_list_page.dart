import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/model/club_member/club_member.dart';
import 'package:woohakdong/service/general/general_functions.dart';
import 'package:woohakdong/view/club_member/components/club_member_assigned_term_bottom_sheet.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../view_model/club_member/club_member_provider.dart';
import '../../view_model/club_member/components/club_selected_term_provider.dart';
import '../themes/custom_widget/etc/custom_horizontal_divider.dart';
import '../themes/custom_widget/interaction/custom_loading_skeleton.dart';
import 'club_member_search_page.dart';
import 'components/club_member_list_tile.dart';

class ClubMemberListPage extends ConsumerWidget {
  const ClubMemberListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clubHistoryUsageDate = ref.watch(clubSelectedTermProvider);

    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            showModalBottomSheet(
              useSafeArea: true,
              context: context,
              builder: (context) => const ClubMemberAssignedTermBottomSheet(),
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('회원'),
              const Gap(defaultGapS),
              if (clubHistoryUsageDate!.isNotEmpty)
                Text(
                  GeneralFunctions.formatClubAssignedTerm(clubHistoryUsageDate),
                  style: context.textTheme.bodyMedium,
                ),
              const Gap(defaultGapS / 2),
              const Icon(
                Symbols.keyboard_arrow_down_rounded,
                size: 20,
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _pushMemberSearchPage(context),
            icon: const Icon(Symbols.search_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: FutureBuilder(
            future: ref.watch(clubMemberProvider.notifier).getClubMemberList(),
            builder: (context, clubMemberSnapshot) {
              final isLoading = clubMemberSnapshot.connectionState == ConnectionState.waiting;

              final clubMemberList = isLoading ? _generateFakeClubMember(10) : clubMemberSnapshot.data;

              if (clubMemberList != null && clubMemberList.isNotEmpty) {
                clubMemberList.sort((a, b) => a.memberName!.compareTo(b.memberName!));
              }

              if (!isLoading && (clubMemberList == null || clubMemberList.isEmpty)) {
                return Center(
                  child: Text(
                    '이 학기에 등록된 회원이 없어요',
                    style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                  ),
                );
              }

              return CustomMaterialIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(milliseconds: 500));
                  ref.invalidate(clubMemberProvider);
                },
                child: CustomLoadingSkeleton(
                  isLoading: isLoading,
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const CustomHorizontalDivider(),
                    itemCount: clubMemberList!.length,
                    itemBuilder: (context, index) => ClubMemberListTile(clubMember: clubMemberList[index]),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List<ClubMember> _generateFakeClubMember(int count) {
    return List.generate(count, (index) {
      return ClubMember(
        memberName: '강동우',
        clubMemberRole: 'MEMBER',
        memberMajor: '소프트웨어학과',
        memberStudentNumber: '201802784',
      );
    });
  }

  void _pushMemberSearchPage(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => const ClubMemberSearchPage()),
    );
  }
}
