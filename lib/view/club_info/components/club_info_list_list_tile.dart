import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/model/club/club.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../model/club_member/club_member_me.dart';
import '../../../repository/club_member/club_member_me_repository.dart';
import '../../../service/general/general_functions.dart';
import '../../../view_model/club/club_id_provider.dart';
import '../../themes/spacing.dart';

class ClubInfoListListTile extends ConsumerWidget {
  final Club club;
  final bool isCurrent;

  const ClubInfoListListTile({
    super.key,
    required this.club,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageProvider = (club.clubImage != null && club.clubImage!.isNotEmpty)
        ? CachedNetworkImageProvider(club.clubImage!)
        : const AssetImage('assets/images/club/club_basic_image.jpg') as ImageProvider;
    final ClubMemberMeRepository clubMemberMeRepository = ClubMemberMeRepository();

    return InkWell(
      onTap: () async {
        final ClubMemberMe clubMemberMe = await clubMemberMeRepository.getClubMemberMe(club.clubId!);

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
      },
      highlightColor: context.colorScheme.onInverseSurface,
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
                  border: Border.all(
                    color: context.colorScheme.onInverseSurface,
                  ),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(defaultGapXL),
              Expanded(
                child: Text(
                  club.clubName!,
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
}
