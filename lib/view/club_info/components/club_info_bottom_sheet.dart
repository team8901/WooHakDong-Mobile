import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/club_info/components/club_info_list_list_tile.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../view_model/club/club_id_provider.dart';
import '../../../view_model/club/club_list_provider.dart';
import '../../club_register/club_register_caution_page_.dart';
import '../../themes/spacing.dart';

class ClubInfoBottomSheet extends ConsumerWidget {
  const ClubInfoBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentClubId = ref.watch(clubIdProvider);
    final clubList = ref.watch(clubListProvider);

    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.36,
      child: ListView.separated(
        padding: const EdgeInsets.only(bottom: defaultPaddingM),
        separatorBuilder: (context, index) => const Gap(defaultGapS),
        itemCount: clubList.length + 2,
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
                  Text('동아리 목록', style: context.textTheme.titleLarge),
                  const Gap(defaultGapS / 4),
                  Text(
                    '현재 등록되어 있는 동아리 목록이에요',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            );
          } else if (index != clubList.length + 1) {
            final club = clubList[index - 1];
            final isCurrent = club.clubId == currentClubId;

            return ClubInfoListListTile(club: club, isCurrent: isCurrent);
          } else {
            return Column(
              children: [
                InkWell(
                  onTap: () => _pushClubRegisterCautionPage(context),
                  highlightColor: context.colorScheme.surfaceContainer,
                  child: Ink(
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
                            child: Icon(Symbols.add_rounded, color: context.colorScheme.onSurface),
                          ),
                        ),
                        const Gap(defaultGapXL),
                        Text(
                          '동아리 추가',
                          style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onSurface),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  void _pushClubRegisterCautionPage(BuildContext context) {
    Navigator.of(context).pop();

    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const ClubRegisterCautionPage(),
      ),
    );
  }
}
