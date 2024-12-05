import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:share_plus/share_plus.dart';
import 'package:woohakdong/model/group/group.dart';
import 'package:woohakdong/view/group/components/group_list_tile.dart';
import 'package:woohakdong/view/group/group_detail_page.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_loading_skeleton.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_refresh_indicator.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/group/group_list_provider.dart';
import 'package:woohakdong/view_model/group/group_provider.dart';

import '../../service/general/general_format.dart';
import '../../service/general/general_functions.dart';
import '../themes/custom_widget/dialog/custom_interaction_dialog.dart';
import '../themes/custom_widget/etc/custom_horizontal_divider.dart';
import 'group_add_page.dart';
import 'group_edit_page.dart';

class GroupListPage extends ConsumerWidget {
  const GroupListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupListData = ref.watch(groupListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('모임'),
        actions: [
          IconButton(
            icon: Icon(Symbols.add_rounded, color: context.colorScheme.primary),
            onPressed: () => _pushGroupAddPage(context),
          ),
        ],
      ),
      body: SafeArea(
        child: groupListData.when(
          data: (groupList) {
            if (groupList.isEmpty) {
              return Center(
                child: Text(
                  '아직 등록된 모임이 없어요',
                  style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                ),
              );
            }

            return CustomRefreshIndicator(
              onRefresh: () async => ref.read(groupListProvider.notifier).getGroupList(),
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const CustomHorizontalDivider(),
                itemCount: groupList.length,
                itemBuilder: (context, index) => GroupListTile(
                  group: groupList[index],
                  onTap: () => _pushGroupDetailPage(ref, context, groupList[index].groupId!),
                  onEditLongPress: () => _pushGroupEditPage(context, groupList[index]),
                  onDeleteLongPress: () async => await _deleteGroup(context, ref, groupList[index]),
                  onShareLongPress: () => _onShareTap(groupList[index]),
                ),
              ),
            );
          },
          loading: () => CustomLoadingSkeleton(
            isLoading: true,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const CustomHorizontalDivider(),
              itemCount: 50,
              itemBuilder: (context, index) => GroupListTile(
                group: Group(
                  groupName: '동아리 MT',
                  groupIsActivated: false,
                  groupDescription: '동아리 MT 모임입니다',
                  groupAmount: 50000,
                  groupMemberCount: 10,
                  groupMemberLimit: 20,
                ),
              ),
            ),
          ),
          error: (error, stack) => Center(
            child: Text(
              '모임 목록을 불러오는 중 오류가 발생했어요\n다시 시도해 주세요',
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

  void _pushGroupAddPage(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => const GroupAddPage(),
      ),
    );
  }

  Future<void> _pushGroupDetailPage(WidgetRef ref, BuildContext context, int groupId) async {
    await ref.read(groupProvider.notifier).getGroupInfo(groupId);

    if (context.mounted) {
      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (context) => const GroupDetailPage(),
        ),
      );
    }
  }

  void _onShareTap(Group groupInfo) {
    Share.share(
      groupInfo.groupJoinLink!,
      subject: '${groupInfo.groupName}에서 만나요! 🤗\n\n'
          '모임비: ${GeneralFormat.formatClubDues(groupInfo.groupAmount!)}\n'
          '최대 인원: ${groupInfo.groupMemberLimit}명\n'
          '현재 인원: ${groupInfo.groupMemberCount}명\n\n',
    );
  }

  void _pushGroupEditPage(BuildContext context, Group groupInfo) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => GroupEditPage(groupInfo: groupInfo),
      ),
    );
  }

  Future<void> _deleteGroup(BuildContext context, WidgetRef ref, Group groupInfo) async {
    try {
      final bool? isDelete = await showDialog<bool>(
        context: context,
        builder: (context) => const CustomInteractionDialog(
          dialogTitle: '모임 삭제',
          dialogContent: '모임을 삭제하면 되돌릴 수 없어요.',
        ),
      );

      if (isDelete != true) return;

      await ref.read(groupProvider.notifier).deleteGroup(groupInfo.groupId!);
      GeneralFunctions.toastMessage('모임이 삭제되었어요');
    } catch (e) {
      GeneralFunctions.toastMessage('오류가 발생했어요\n다시 시도해 주세요');
    }
  }
}
