import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/model/club/current_club_account.dart';
import 'package:woohakdong/model/club_member/club_member_me.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../service/general/general_format.dart';

class ClubDuesAccountInfoBox extends ConsumerWidget {
  final ClubMemberMe clubMemberMe;
  final CurrentClubAccount currentClubAccount;
  final String? duesInOutType;
  final DateTime duesDateTime;
  final Function(ClubMemberMe) onRefresh;
  final VoidCallback onInOutTypeTap;
  final VoidCallback onDateTimeTap;

  const ClubDuesAccountInfoBox({
    super.key,
    required this.clubMemberMe,
    required this.currentClubAccount,
    required this.duesInOutType,
    required this.duesDateTime,
    required this.onRefresh,
    required this.onInOutTypeTap,
    required this.onDateTimeTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: defaultPaddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    currentClubAccount.clubAccountBankName!,
                    style: context.textTheme.bodySmall,
                  ),
                  const Gap(defaultGapS / 2),
                  Text(
                    currentClubAccount.clubAccountNumber!,
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
              const Gap(defaultGapS / 2),
              Text(
                GeneralFormat.formatClubDues(currentClubAccount.clubAccountBalance!),
                style: context.textTheme.headlineLarge?.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        const Gap(defaultGapXL * 2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPaddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => onRefresh(clubMemberMe),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        '${GeneralFormat.formatDateTime(currentClubAccount.clubAccountLastUpdateDate!)} 기준',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    const Gap(defaultGapS / 2),
                    Icon(
                      Symbols.refresh_rounded,
                      size: 16,
                      color: context.colorScheme.onSurface,
                    ),
                  ],
                ),
              ),
              const Gap(defaultGapS),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: onInOutTypeTap,
                    child: Row(
                      children: [
                        Text(
                          _getFilterText(duesInOutType),
                          style: context.textTheme.bodyLarge,
                        ),
                        const Gap(defaultGapS / 2),
                        const Icon(
                          Symbols.keyboard_arrow_down_rounded,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                  const Gap(defaultGapM),
                  InkWell(
                    onTap: onDateTimeTap,
                    child: Row(
                      children: [
                        Text(
                          DateFormat('yyyy년 M월').format(duesDateTime),
                          style: context.textTheme.bodyLarge,
                        ),
                        const Gap(defaultGapS / 2),
                        const Icon(
                          Symbols.keyboard_arrow_down_rounded,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getFilterText(String? type) {
    switch (type) {
      case 'DEPOSIT':
        return '입금';
      case 'WITHDRAW':
        return '출금';
      default:
        return '전체';
    }
  }
}
