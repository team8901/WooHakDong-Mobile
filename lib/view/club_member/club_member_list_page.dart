import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../view_model/club_member/club_member_provider.dart';
import '../themes/custom_widget/custom_circular_progress_indicator.dart';
import '../themes/custom_widget/custom_divider.dart';
import '../themes/spacing.dart';
import 'club_member_search_page.dart';

class ClubMemberListPage extends ConsumerWidget {
  const ClubMemberListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원'),
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
                        onTap: () {},
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
                                                _getRoleDisplayName(clubMember.clubMemberRole!),
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
                                )
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

  String _getRoleDisplayName(String role) {
    switch (role) {
      case 'PRESIDENT':
        return '회장';
      case 'OFFICER':
        return '임원진';
      case 'MEMBER':
        return '일반 회원';
      default:
        return '회원';
    }
  }

  String _getAssignedTermDisplay(String term) {
    final date = DateTime.tryParse(term);

    if (date == null) return term;

    final year = date.year;
    final month = date.month;

    if (month >= 1 && month <= 6) {
      return '$year년 1학기';
    } else if (month >= 7 && month <= 12) {
      return '$year년 2학기';
    }

    return term;
  }

  void _pushMemberSearchPage(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => const ClubMemberSearchPage()),
    );
  }
}
