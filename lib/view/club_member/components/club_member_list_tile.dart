import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/model/club_member/club_member.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../service/general/general_functions.dart';
import '../../../view_model/club_member/club_member_provider.dart';
import '../../themes/custom_widget/etc/custom_vertical_divider.dart';
import '../../themes/spacing.dart';
import '../club_member_detail_page.dart';

class ClubMemberListTile extends ConsumerStatefulWidget {
  final ClubMember clubMember;

  const ClubMemberListTile({
    super.key,
    required this.clubMember,
  });

  @override
  ConsumerState<ClubMemberListTile> createState() => _ClubMemberListTileState();
}

class _ClubMemberListTileState extends ConsumerState<ClubMemberListTile> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _isProcessing
          ? null
          : () async {
              setState(() {
                _isProcessing = true;
              });

              await _pushMemberDetailPage(context);

              setState(() {
                _isProcessing = false;
              });
            },
      highlightColor: context.colorScheme.surfaceContainer,
      child: Ink(
        padding: const EdgeInsets.all(defaultPaddingM),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(widget.clubMember.memberName!, style: context.textTheme.bodyLarge),
                      const Gap(defaultGapS / 2),
                      if (widget.clubMember.clubMemberRole != 'MEMBER')
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: defaultPaddingXS / 2,
                              vertical: defaultPaddingXS / 6,
                            ),
                            decoration: BoxDecoration(
                              color: context.colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(defaultBorderRadiusM / 2),
                            ),
                            child: Text(
                              GeneralFunctions.formatClubRole(widget.clubMember.clubMemberRole!),
                              style: context.textTheme.labelLarge?.copyWith(color: context.colorScheme.primary),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const Gap(defaultGapS / 2),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          widget.clubMember.memberMajor!,
                          style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                          softWrap: true,
                        ),
                      ),
                      const Gap(defaultGapS),
                      const CustomVerticalDivider(),
                      const Gap(defaultGapS),
                      Flexible(
                        child: Text(
                          widget.clubMember.memberStudentNumber!,
                          style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(defaultGapM),
            Icon(
              Symbols.chevron_right_rounded,
              color: context.colorScheme.outline,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pushMemberDetailPage(BuildContext context) async {
    await ref.read(clubMemberProvider.notifier).getClubMemberInfo(widget.clubMember.clubMemberId!);

    if (context.mounted) {
      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (context) => const ClubMemberDetailPage(),
        ),
      );
    }
  }
}
