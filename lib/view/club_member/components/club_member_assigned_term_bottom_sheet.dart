import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/main.dart';
import '../../../service/general/general_functions.dart';
import '../../../view_model/club_member/club_member_provider.dart';
import '../../../view_model/club_member/club_member_term_provider.dart';
import '../../../view_model/club_member/components/club_selected_term_provider.dart';
import '../../themes/spacing.dart';
import '../../themes/theme_context.dart';

class ClubMemberAssignedTermBottomSheet extends ConsumerWidget {
  const ClubMemberAssignedTermBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTerm = ref.watch(clubSelectedTermProvider);

    return SizedBox(
      width: double.infinity,
      child: FutureBuilder(
        future: ref.watch(clubMemberTermProvider.notifier).getClubMemberTermList(),
        builder: (context, termListSnapshot) {
          if (termListSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (termListSnapshot.hasError) {
            return Text('동아리 가입 분기 목록을 불러올 수 없어요', style: context.textTheme.bodyLarge);
          } else {
            final termList = (termListSnapshot.data ?? []).reversed.toList();

            return ListView.separated(
              padding: const EdgeInsets.only(bottom: defaultPaddingM),
              separatorBuilder: (context, index) => const Gap(defaultGapS),
              itemCount: termList.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPaddingM,
                      vertical: defaultPaddingS / 2,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('동아리 분기 목록', style: context.textTheme.titleLarge),
                        const Gap(defaultGapS / 4),
                        Text(
                          '각 분기별 동아리 회원을 확인할 수 있어요',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  final term = termList[index - 1];
                  final termDate = DateFormat('yyyy-MM-dd').format(term.clubHistoryUsageDate!);
                  final isCurrent = termDate == selectedTerm;

                  return InkWell(
                    onTap: () {
                      ref.read(clubSelectedTermProvider.notifier).state = termDate;
                      ref.invalidate(clubMemberProvider);

                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    highlightColor: context.colorScheme.surfaceContainer,
                    child: Ink(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: defaultPaddingM,
                          vertical: defaultPaddingS / 2,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 40.r,
                              height: 40.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: context.colorScheme.surfaceContainer,
                              ),
                              child: Center(
                                child: Icon(
                                  Symbols.calendar_month_rounded,
                                  color: context.colorScheme.onSurface,
                                ),
                              ),
                            ),
                            const Gap(defaultGapXL),
                            Expanded(
                              child: Text(
                                GeneralFunctions.formatClubAssignedTerm(term.clubHistoryUsageDate.toString()),
                                style: context.textTheme.bodyLarge,
                                softWrap: true,
                              ),
                            ),
                            const Gap(defaultGapXL),
                            if (isCurrent)
                              Icon(
                                size: 20,
                                Symbols.check_circle_rounded,
                                fill: 1,
                                color: context.colorScheme.primary,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}