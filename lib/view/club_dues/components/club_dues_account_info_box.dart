import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/model/club/current_club_account.dart';
import 'package:woohakdong/service/general/general_functions.dart';
import 'package:woohakdong/view/club_dues/components/club_dues_in_out_type_bottom_sheet.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../view_model/dues/dues_provider.dart';

class ClubDuesAccountInfoBox extends ConsumerWidget {
  final CurrentClubAccount currentClubAccount;
  final String? duesInOutType;
  final Function(String?) onTypeSelect;

  const ClubDuesAccountInfoBox({
    super.key,
    required this.currentClubAccount,
    required this.duesInOutType,
    required this.onTypeSelect,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(defaultPaddingM),
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
                GeneralFunctions.formatClubDues(currentClubAccount.clubAccountBalance!),
                style: context.textTheme.headlineLarge?.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Gap(defaultGapXL),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPaddingM),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    useSafeArea: true,
                    context: context,
                    builder: (context) => ClubDuesInOutTypeBottomSheet(onTypeSelect: onTypeSelect),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      _getFilterText(duesInOutType),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    const Gap(defaultGapS / 2),
                    Icon(
                      Symbols.keyboard_arrow_down_rounded,
                      size: 16,
                      color: context.colorScheme.onSurface,
                    ),
                  ],
                ),
              ),
              const Gap(defaultGapM),
              Flexible(
                child: InkWell(
                  onTap: () async {
                    try {
                      await ref.read(duesProvider.notifier).refreshDuesList();
                      await ref.refresh(duesProvider.notifier).getDuesList(null);

                      await GeneralFunctions.toastMessage('회비 내역을 업데이트 했어요');
                    } catch (e) {
                      await GeneralFunctions.toastMessage('회비 내역 업데이트에 실패했어요');
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          DateFormat('yyyy년 M월 dd일 H:MM 기준').format(
                            currentClubAccount.clubAccountLastUpdateDate!,
                          ),
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
