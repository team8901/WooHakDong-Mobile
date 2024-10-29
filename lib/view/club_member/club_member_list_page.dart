import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/model/club_member/club_member.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../service/general/general_functions.dart';
import '../../view_model/club_member/club_member_provider.dart';
import '../themes/custom_widget/custom_circular_progress_indicator.dart';
import '../themes/custom_widget/custom_divider.dart';
import '../themes/spacing.dart';
import 'club_member_detail_page.dart';
import 'club_member_search_page.dart';

class ClubMemberListPage extends ConsumerWidget {
  const ClubMemberListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원'),
        actions: [
          /// 검색 기능 추가하기
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
            future: ref.watch(clubMemberProvider.notifier).getClubMemberList(null),
            builder: (context, clubMemberSnapshot) {
              if (clubMemberSnapshot.connectionState == ConnectionState.waiting) {
                return const CustomCircularProgressIndicator();
              } else {
                final clubMemberList = clubMemberSnapshot.data;
                if (clubMemberList != null && clubMemberList.isNotEmpty) {
                  clubMemberList.sort((a, b) => a.memberName!.compareTo(b.memberName!));
                }

                if (clubMemberList!.isEmpty) {
                  return Center(
                    child: Text(
                      '아직 동아리 회원이 없어요',
                      style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                    ),
                  );
                }

                return CustomMaterialIndicator(
                  onRefresh: () async {
                    await Future.delayed(const Duration(milliseconds: 750));
                    ref.refresh(clubMemberProvider);
                  },
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) => const CustomDivider(),
                    itemCount: clubMemberList.length,
                    itemBuilder: (context, index) {
                      final clubMember = clubMemberList[index];

                      return InkWell(
                        onTap: () => _pushMemberDetailPage(context, clubMember),
                        highlightColor: context.colorScheme.surfaceContainer,
                        child: Ink(
                          child: Padding(
                            padding: const EdgeInsets.all(defaultPaddingM),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(clubMember.memberName!, style: context.textTheme.bodyLarge),
                                          const Gap(defaultGapS / 2),
                                          if (clubMember.clubMemberRole != 'MEMBER')
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: defaultPaddingXS / 2,
                                                vertical: defaultPaddingXS / 6,
                                              ),
                                              decoration: BoxDecoration(
                                                color: context.colorScheme.primary.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(defaultBorderRadiusM / 2),
                                              ),
                                              child: Text(
                                                GeneralFunctions.getRoleDisplayName(clubMember.clubMemberRole!),
                                                style: context.textTheme.labelLarge
                                                    ?.copyWith(color: context.colorScheme.primary),
                                              ),
                                            ),
                                        ],
                                      ),
                                      const Gap(defaultGapS / 2),
                                      Row(
                                        children: [
                                          Text(
                                            clubMember.memberMajor!,
                                            style: context.textTheme.bodySmall
                                                ?.copyWith(color: context.colorScheme.onSurface),
                                            softWrap: true,
                                          ),
                                          const Gap(defaultGapS),
                                          SizedBox(
                                            height: 8,
                                            child: VerticalDivider(
                                              color: context.colorScheme.outline,
                                              width: 1,
                                            ),
                                          ),
                                          const Gap(defaultGapS),
                                          Text(
                                            clubMember.memberStudentNumber!,
                                            style: context.textTheme.bodySmall
                                                ?.copyWith(color: context.colorScheme.onSurface),
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Gap(defaultGapS),
                                Icon(
                                  Symbols.chevron_right_rounded,
                                  color: context.colorScheme.outline,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }


  void _pushMemberSearchPage(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => const ClubMemberSearchPage()),
    );
  }

  void _pushMemberDetailPage(BuildContext context, ClubMember clubMember) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => ClubMemberDetailPage(clubMember: clubMember)),
    );
  }
}
