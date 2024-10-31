import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class ClubMemberRoleDialog extends StatelessWidget {
  final String? selectedRole;
  final ValueChanged<String?> onRoleSelected;

  const ClubMemberRoleDialog({
    super.key,
    required this.selectedRole,
    required this.onRoleSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(defaultPaddingS * 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadiusL),
          color: context.colorScheme.surfaceDim,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('역할 변경', style: context.textTheme.titleMedium),
            const Gap(defaultGapS / 2),
            Text(
              '변경하려는 역할을 선택해 주세요',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurface,
              ),
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
                  _buildRoleOption(context, '', '부회장'),
                  _buildRoleOption(context, '', '총무'),
                  _buildRoleOption(context, 'OFFICER', '기타 임원진'),
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
              child: _buildRoleOption(context, 'MEMBER', '회원'),
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
                  onTap: () {
                    Navigator.pop(context);
                    onRoleSelected(selectedRole);
                  },
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

  Widget _buildRoleOption(BuildContext context, String roleValue, String roleText) {
    return Row(
      children: [
        Radio<String>(
          value: roleValue,
          groupValue: selectedRole,
          onChanged: (value) => onRoleSelected(value),
        ),
        Text(
          roleText,
          style: context.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
