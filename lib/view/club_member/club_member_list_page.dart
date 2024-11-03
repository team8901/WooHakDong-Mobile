import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/model/club_member/club_member.dart';
import 'package:woohakdong/service/general/general_functions.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/club_member/club_member_term_provider.dart';

import '../../model/club_member/club_member_term.dart';
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
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text('회원'),
            const Gap(defaultGapS),
            if (clubHistoryUsageDate!.isNotEmpty)
              Text(
                GeneralFunctions.formatClubAssignedTerm(clubHistoryUsageDate),
                style: context.textTheme.bodyMedium,
              ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => _pushMemberSearchPage(context),
            icon: const Icon(Symbols.search_rounded),
          ),
          FutureBuilder(
            future: ref.watch(clubMemberTermProvider.notifier).getClubMemberTermList(),
            builder: (context, snapshot) {
              final termList = snapshot.data ?? [];

              return PopupMenuButton<ClubMemberTerm>(
                padding: EdgeInsets.zero,
                elevation: 0,
                icon: const Icon(Symbols.reorder_rounded),
                onSelected: (ClubMemberTerm term) {
                  final selectedTerm = DateFormat('yyyy-MM-dd').format(term.clubHistoryUsageDate!);

                  ref.read(clubSelectedTermProvider.notifier).state = selectedTerm;

                  ref.invalidate(clubMemberProvider);
                },
                itemBuilder: (context) {
                  return [
                    for (final term in termList)
                      PopupMenuItem<ClubMemberTerm>(
                        padding: const EdgeInsets.symmetric(
                          horizontal: defaultPaddingS,
                          vertical: defaultPaddingXS,
                        ),
                        value: term,
                        child: Text(
                          GeneralFunctions.formatClubAssignedTerm(term.clubHistoryUsageDate.toString()),
                          style: context.textTheme.bodyMedium,
                        ),
                      ),
                  ];
                },
              );
            },
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

              final clubMemberList = isLoading ? generateFakeClubMember(10) : clubMemberSnapshot.data;

              if (clubMemberList != null && clubMemberList.isNotEmpty) {
                clubMemberList.sort((a, b) => a.memberName!.compareTo(b.memberName!));
              }

              if (!isLoading && (clubMemberList == null || clubMemberList.isEmpty)) {
                return Center(
                  child: Text(
                    '아직 등록된 물품이 없어요',
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

  List<ClubMember> generateFakeClubMember(int count) {
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
