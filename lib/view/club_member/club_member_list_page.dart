import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/model/club_member/club_member.dart';
import 'package:woohakdong/service/general/general_functions.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../view_model/club_member/club_member_provider.dart';
import '../themes/custom_widget/etc/custom_divider.dart';
import '../themes/custom_widget/interaction/custom_loading_skeleton.dart';
import 'club_member_search_page.dart';
import 'components/club_member_list_tile.dart';

class ClubMemberListPage extends ConsumerWidget {
  const ClubMemberListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime? selectedTerm;

    return Scaffold(
      appBar: AppBar(
        title: const Text('회원'),
        actions: [
          IconButton(
            onPressed: () => _pushMemberSearchPage(context),
            icon: const Icon(Symbols.search_rounded),
          ),
          FutureBuilder(
            future: ref.watch(clubMemberProvider.notifier).getClubMemberTermList(),
            builder: (context, snapshot) {
              final termList = snapshot.data ?? [];

              return PopupMenuButton<DateTime?>(
                icon: const Icon(Symbols.reorder_rounded),
                onSelected: (DateTime? term) {
                  selectedTerm = term;
                  ref.refresh(clubMemberProvider);
                },
                itemBuilder: (context) {
                  return [
                    for (final term in termList)
                      PopupMenuItem<DateTime>(
                        value: term,
                        child: Text(
                          GeneralFunctions.formatClubAssignedTerm(term.toIso8601String()),
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
            future: ref.watch(clubMemberProvider.notifier).getClubMemberList(selectedTerm),
            builder: (context, clubMemberSnapshot) {
              final isLoading = clubMemberSnapshot.connectionState == ConnectionState.waiting;

              final clubMemberList = isLoading ? generateFakeClubMember(10) : clubMemberSnapshot.data;

              if (clubMemberList != null && clubMemberList.isNotEmpty) {
                clubMemberList.sort((a, b) => a.memberName!.compareTo(b.memberName!));
              }

              return CustomMaterialIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(milliseconds: 750));
                  ref.refresh(clubMemberProvider);
                },
                child: CustomLoadingSkeleton(
                  isLoading: isLoading,
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const CustomDivider(),
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
