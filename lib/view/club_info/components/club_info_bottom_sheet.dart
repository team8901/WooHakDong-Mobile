import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/club_info/components/club_info_list_tile.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../model/club/club.dart';
import '../../../model/club_member/club_member_me.dart';
import '../../../repository/club_member/club_member_me_repository.dart';
import '../../../service/general/general_functions.dart';
import '../../../view_model/club/club_id_provider.dart';
import '../../club_register/club_register_caution_page_.dart';
import '../../themes/spacing.dart';

class ClubInfoBottomSheet extends ConsumerWidget {
  final int currentClubId;
  final List<Club> clubList;

  const ClubInfoBottomSheet({
    super.key,
    required this.currentClubId,
    required this.clubList,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.4,
        minHeight: MediaQuery.of(context).size.height * 0.2,
      ),
      child: ListView.separated(
        shrinkWrap: true,
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
                    '현재 가입되어 있는 동아리 목록이에요',
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

            return ClubInfoListTile(
              club: club,
              isCurrent: isCurrent,
              onTap: () => _changeClub(club, ref, context),
            );
          } else {
            return InkWell(
              onTap: () => _pushClubRegisterCautionPage(context),
              highlightColor: context.colorScheme.surfaceContainer,
              child: Ink(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPaddingM,
                  vertical: defaultPaddingM / 2,
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
                      '동아리 등록하기',
                      style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onSurface),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _changeClub(Club club, WidgetRef ref, BuildContext context) async {
    final ClubMemberMe clubMemberMe = await ClubMemberMeRepository().getClubMemberMe(club.clubId!);

    if (clubMemberMe.clubMemberRole == 'MEMBER') {
      await GeneralFunctions.toastMessage('동아리 임원진만 이용할 수 있어요');
      return;
    }

    await ref.read(clubIdProvider.notifier).saveClubId(club.clubId!);

    if (context.mounted) {
      Navigator.of(context).pop();
      await Phoenix.rebirth(context);
      await GeneralFunctions.toastMessage('${club.clubName} 동아리로 전환되었어요');
    }
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
