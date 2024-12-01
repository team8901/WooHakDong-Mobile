import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/club_member/components/dialog/club_member_assigned_term_bottom_sheet.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_loading_skeleton.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_tap_debouncer.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/club_member/club_member_term_list_provider.dart';

import '../../model/club_member/club_member.dart';
import '../../service/general/general_format.dart';
import '../../view_model/club_member/club_member_list_provider.dart';
import '../../view_model/club_member/club_member_provider.dart';
import '../../view_model/club_member/components/club_selected_term_provider.dart';
import '../themes/custom_widget/etc/custom_horizontal_divider.dart';
import '../themes/custom_widget/interaction/custom_refresh_indicator.dart';
import 'club_member_detail_page.dart';
import 'club_member_search_page.dart';
import 'components/list_tile/club_member_list_tile.dart';

class ClubMemberListPage extends ConsumerStatefulWidget {
  const ClubMemberListPage({super.key});

  @override
  ConsumerState<ClubMemberListPage> createState() => _ClubMemberListPageState();
}

class _ClubMemberListPageState extends ConsumerState<ClubMemberListPage> {
  @override
  Widget build(BuildContext context) {
    final clubHistoryUsageDate = ref.watch(clubSelectedTermProvider);
    final clubMemberListData = ref.watch(clubMemberListProvider);

    return Scaffold(
      appBar: AppBar(
        title: CustomTapDebouncer(
          onTap: () async {
            await ref.read(clubMemberTermListProvider.notifier).getClubMemberTermList();

            if (context.mounted) {
              showModalBottomSheet(
                useSafeArea: true,
                context: context,
                builder: (context) => const ClubMemberAssignedTermBottomSheet(),
              );
            }
          },
          builder: (context, onTap) {
            return InkWell(
              onTap: onTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('회원'),
                  const Gap(defaultGapS),
                  if (clubHistoryUsageDate!.isNotEmpty)
                    Text(
                      GeneralFormat.formatClubAssignedTerm(clubHistoryUsageDate),
                      style: context.textTheme.bodyMedium,
                    ),
                  const Gap(defaultGapS / 2),
                  const Icon(
                    Symbols.keyboard_arrow_down_rounded,
                    size: 20,
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () => _pushMemberSearchPage(context),
            icon: const Icon(Symbols.search_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: clubMemberListData.when(
          data: (clubMemberList) {
            if (clubMemberList.isEmpty) {
              return Center(
                child: Text(
                  '이 학기에 등록된 회원이 없어요',
                  style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                ),
              );
            }

            clubMemberList.sort((a, b) => a.memberName!.compareTo(b.memberName!));

            return CustomRefreshIndicator(
              onRefresh: () async => await ref.read(clubMemberListProvider.notifier).getClubMemberList(),
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const CustomHorizontalDivider(),
                itemCount: clubMemberList.length,
                itemBuilder: (context, index) => ClubMemberListTile(
                  clubMember: clubMemberList[index],
                  onTap: () => _pushMemberDetailPage(ref, context, clubMemberList[index].clubMemberId!),
                ),
              ),
            );
          },
          loading: () => CustomLoadingSkeleton(
            isLoading: true,
            child: ListView.separated(
              separatorBuilder: (context, index) => const CustomHorizontalDivider(),
              itemCount: 50,
              itemBuilder: (context, index) {
                return ClubMemberListTile(
                  clubMember: ClubMember(
                    memberName: '우학동',
                    memberMajor: '소프트웨어학과',
                    memberStudentNumber: '202411111',
                    clubMemberRole: 'MEMBER',
                  ),
                );
              },
            ),
          ),
          error: (error, stack) => Center(
            child: Text(
              '회원 목록을 불러오는 중 오류가 발생했어요\n다시 시도해 주세요',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pushMemberDetailPage(WidgetRef ref, BuildContext context, int clubMemberId) async {
    await ref.read(clubMemberProvider.notifier).getClubMemberInfo(clubMemberId);

    if (context.mounted) {
      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (context) => const ClubMemberDetailPage(),
        ),
      );
    }
  }

  void _pushMemberSearchPage(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => const ClubMemberSearchPage()),
    );
  }
}
