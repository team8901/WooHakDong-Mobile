import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_progress_indicator.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/group/group_member_list_provider.dart';

import '../../../view_model/club_member/club_member_provider.dart';
import '../../club_member/club_member_detail_page.dart';
import '../../themes/custom_widget/etc/custom_horizontal_divider.dart';
import '../../themes/spacing.dart';
import 'group_member_list_tile.dart';

class GroupMemberPanel extends ConsumerStatefulWidget {
  final String groupName;
  final int groupId;

  const GroupMemberPanel({
    super.key,
    required this.groupName,
    required this.groupId,
  });

  @override
  ConsumerState<GroupMemberPanel> createState() => _ClubMemberItemHistoryPanelState();
}

class _ClubMemberItemHistoryPanelState extends ConsumerState<GroupMemberPanel> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final groupMemberListData = ref.watch(groupMemberListProvider(widget.groupId));

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.colorScheme.surfaceContainer),
        borderRadius: BorderRadius.circular(defaultBorderRadiusM),
      ),
      clipBehavior: Clip.antiAlias,
      child: ExpansionPanelList(
        elevation: 0,
        expandedHeaderPadding: EdgeInsets.zero,
        expansionCallback: (_, __) => _handleExpansion(!_isExpanded),
        children: [
          ExpansionPanel(
            isExpanded: _isExpanded,
            backgroundColor: Colors.transparent,
            canTapOnHeader: true,
            headerBuilder: (context, isExpanded) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPaddingS,
                  vertical: defaultPaddingXS,
                ),
                child: Row(
                  children: [
                    Icon(
                      Symbols.handshake_rounded,
                      size: 16,
                      color: context.colorScheme.outline,
                    ),
                    const Gap(defaultGapM),
                    Expanded(
                      child: Text(
                        '${widget.groupName} 참여 회원 보기',
                        style: context.textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
              );
            },
            body: groupMemberListData.when(
              data: (groupMemberList) {
                if (groupMemberList.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(defaultPaddingM),
                    child: Center(
                      child: Text(
                        '아직 모임에 참여한 회원이 없어요',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const CustomHorizontalDivider(),
                  itemCount: groupMemberList.length,
                  itemBuilder: (context, index) => GroupMemberListTile(
                    groupMember: groupMemberList[index],
                    onTap: () => _pushMemberDetailPage(ref, context, groupMemberList[index].clubMemberId!),
                  ),
                );
              },
              loading: () => CustomProgressIndicator(
                indicatorColor: context.colorScheme.surfaceContainer,
              ),
              error: (error, stack) => Padding(
                padding: const EdgeInsets.all(defaultPaddingM),
                child: Center(
                  child: Text(
                    '모임 참여 회원을 불러오는 중 오류가 발생했어요\n다시 시도해 주세요',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
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

  void _handleExpansion(bool isExpanded) {
    setState(
      () {
        _isExpanded = isExpanded;

        if (isExpanded) {
          ref.read(groupMemberListProvider(widget.groupId).notifier).getGroupMemberList(widget.groupId);
        }
      },
    );
  }
}
