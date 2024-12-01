import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/model/group/group.dart';
import 'package:woohakdong/view/group/components/group_list_tile.dart';
import 'package:woohakdong/view/group/group_detail_page.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_loading_skeleton.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_refresh_indicator.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/group/group_list_provider.dart';
import 'package:woohakdong/view_model/group/group_provider.dart';

import '../themes/custom_widget/etc/custom_horizontal_divider.dart';
import 'group_add_page.dart';

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
}
