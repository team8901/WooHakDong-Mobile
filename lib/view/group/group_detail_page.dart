import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:share_plus/share_plus.dart';
import 'package:woohakdong/service/general/general_format.dart';
import 'package:woohakdong/view/group/components/group_member_panel.dart';
import 'package:woohakdong/view/group/group_edit_page.dart';
import 'package:woohakdong/view/themes/custom_widget/interface/custom_info_box.dart';
import 'package:woohakdong/view/themes/custom_widget/interface/custom_info_content.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../model/group/group.dart';
import '../../service/general/general_functions.dart';
import '../../view_model/group/group_provider.dart';
import '../themes/custom_widget/button/custom_info_tooltip.dart';
import '../themes/custom_widget/dialog/custom_interaction_dialog.dart';
import '../themes/spacing.dart';

class GroupDetailPage extends ConsumerWidget {
  const GroupDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupInfo = ref.watch(groupProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          if (groupInfo.groupIsActivated!)
            IconButton(
              onPressed: () => _onShareTap(groupInfo),
              icon: const Icon(Symbols.share_rounded),
            ),
          IconButton(
            onPressed: () => _pushGroupEditPage(context, groupInfo),
            icon: const Icon(Symbols.edit_rounded),
          ),
          IconButton(
            onPressed: () async => await _deleteGroup(context, ref, groupInfo),
            icon: const Icon(Symbols.delete_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultPaddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!groupInfo.groupIsActivated!)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: defaultPaddingS,
                        vertical: defaultPaddingXS,
                      ),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                      ),
                      child: Text(
                        '마감된 모임',
                        style: context.textTheme.titleSmall?.copyWith(
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    const Gap(defaultGapXL),
                  ],
                ),
              CustomInfoBox(
                infoTitle: '모임 정보',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomInfoContent(
                      infoContent: groupInfo.groupName!,
                      icon: Icon(
                        Symbols.title_rounded,
                        size: 16,
                        color: context.colorScheme.outline,
                      ),
                    ),
                    const Gap(defaultGapM),
                    CustomInfoContent(
                      infoContent: groupInfo.groupDescription!,
                      icon: Icon(
                        Symbols.info_rounded,
                        size: 16,
                        color: context.colorScheme.outline,
                      ),
                    ),
                    const Gap(defaultGapM),
                    CustomInfoContent(
                      infoContent: GeneralFormat.formatClubDues(groupInfo.groupAmount!),
                      icon: Icon(
                        Symbols.attach_money_rounded,
                        size: 16,
                        color: context.colorScheme.outline,
                      ),
                    ),
                    const Gap(defaultGapM),
                    CustomInfoContent(
                      infoContent: '최대 인원 ${groupInfo.groupMemberLimit!}명',
                      icon: Icon(
                        Symbols.groups_rounded,
                        size: 16,
                        color: context.colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(defaultGapXL),
              CustomInfoBox(
                infoTitle: '모임 추가 정보',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomInfoContent(
                      infoContent: groupInfo.groupChatLink!,
                      icon: Icon(
                        Symbols.forum_rounded,
                        size: 16,
                        color: context.colorScheme.outline,
                      ),
                    ),
                    (groupInfo.groupChatPassword != '')
                        ? Column(
                            children: [
                              const Gap(defaultGapXL),
                              CustomInfoContent(
                                infoContent: groupInfo.groupChatPassword!,
                                icon: Icon(
                                  Symbols.key_rounded,
                                  size: 16,
                                  color: context.colorScheme.outline,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              const Gap(defaultGapXL),
              CustomInfoBox(
                infoTitle: '모임 결제 링크',
                infoTitleIcon: const CustomInfoTooltip(
                  tooltipMessage: '모임 결제 링크를 누르면 복사돼요',
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (groupInfo.groupIsActivated!) {
                          GeneralFunctions.clipboardCopy(
                            groupInfo.groupJoinLink!,
                            '모임 결제 링크가 복사되었어요',
                          );
                          return;
                        }
                        GeneralFunctions.toastMessage('마감된 모임이에요');
                      },
                      child: CustomInfoContent(
                        isUnderline: true,
                        infoContent: groupInfo.groupJoinLink!,
                        icon: Icon(
                          Symbols.link_rounded,
                          size: 16,
                          color: context.colorScheme.outline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(defaultGapXL),
              CustomInfoBox(
                infoTitle: '참여 회원',
                child: CustomInfoContent(
                  infoContent: '${groupInfo.groupMemberCount!}명 참여',
                  icon: Icon(
                    Symbols.person_rounded,
                    size: 16,
                    color: context.colorScheme.outline,
                  ),
                ),
              ),
              const Gap(defaultGapM),
              GroupMemberPanel(groupName: groupInfo.groupName!, groupId: groupInfo.groupId!),
            ],
          ),
        ),
      ),
    );
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

      if (context.mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      GeneralFunctions.toastMessage('오류가 발생했어요\n다시 시도해 주세요');
    }
  }
}
