import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/service/general/general_functions.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../../view_model/club_member/club_member_provider.dart';

class ClubMemberRoleEditDialog extends ConsumerStatefulWidget {
  final int clubMemberId;
  final String? initialRole;

  const ClubMemberRoleEditDialog({
    super.key,
    required this.clubMemberId,
    required this.initialRole,
  });

  @override
  ConsumerState<ClubMemberRoleEditDialog> createState() => _RoleSelectionDialogState();
}

class _RoleSelectionDialogState extends ConsumerState<ClubMemberRoleEditDialog> {
  String? selectedRole;

  @override
  void initState() {
    super.initState();
    selectedRole = widget.initialRole;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(defaultPaddingS * 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadiusL),
          color: context.colorScheme.surfaceBright,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('역할 변경', style: context.textTheme.titleMedium),
            const Gap(defaultGapS / 2),
            Text(
              '변경하려는 역할을 선택해 주세요',
              style: context.textTheme.bodyLarge,
            ),
            const Gap(defaultPaddingS * 2),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: context.colorScheme.surfaceContainer),
                borderRadius: BorderRadius.circular(defaultBorderRadiusM),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        activeColor: context.colorScheme.primary,
                        value: 'VICEPRESIDENT',
                        groupValue: selectedRole,
                        onChanged: (value) {
                          setState(() {
                            selectedRole = value;
                          });
                        },
                      ),
                      Text(
                        '부회장',
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        activeColor: context.colorScheme.primary,
                        value: 'SECRETARY',
                        groupValue: selectedRole,
                        onChanged: (value) {
                          setState(() {
                            selectedRole = value;
                          });
                        },
                      ),
                      Text(
                        '총무',
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        activeColor: context.colorScheme.primary,
                        value: 'OFFICER',
                        groupValue: selectedRole,
                        onChanged: (value) {
                          setState(() {
                            selectedRole = value;
                          });
                        },
                      ),
                      Text(
                        '임원',
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(defaultGapXL),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: context.colorScheme.surfaceContainer),
                borderRadius: BorderRadius.circular(defaultBorderRadiusM),
              ),
              child: Row(
                children: [
                  Radio<String>(
                    activeColor: context.colorScheme.primary,
                    value: 'MEMBER',
                    groupValue: selectedRole,
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value;
                      });
                    },
                  ),
                  Text(
                    '회원',
                    style: context.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const Gap(defaultPaddingS * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    '취소',
                    style: context.textTheme.titleSmall,
                  ),
                ),
                const Gap(defaultPaddingS * 2),
                InkWell(
                  onTap: () => _updateRole(context, widget.clubMemberId),
                  child: Text(
                    '확인',
                    style: context.textTheme.titleSmall?.copyWith(
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateRole(context, int clubMemberId) async {
    try {
      final clubNotifier = ref.read(clubMemberProvider.notifier);

      await clubNotifier.updateClubMemberRole(
        clubMemberId,
        selectedRole!,
      );

      if (context.mounted) {
        GeneralFunctions.toastMessage('역할이 변경되었어요');
        Navigator.pop(context);
      }
    } catch (e) {
      await GeneralFunctions.toastMessage('오류가 발생했어요\n다시 시도해 주세요');
      Navigator.pop(context);
    }
  }
}
