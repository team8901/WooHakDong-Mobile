import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../service/general/general_functions.dart';
import '../../../view_model/club/club_id_provider.dart';
import '../../../view_model/club/club_list_provider.dart';
import '../../club_register/club_register_caution_page_.dart';
import '../../route_page.dart';
import '../../themes/spacing.dart';

class ClubInformationBottomSheet extends ConsumerWidget {
  const ClubInformationBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentClubId = ref.watch(clubIdProvider);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(defaultPaddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('동아리 목록', style: context.textTheme.titleLarge),
          Text(
            '현재 등록되어 있는 동아리 목록이에요',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurface,
            ),
          ),
          const Gap(defaultGapXL * 2),
          FutureBuilder(
            future: ref.watch(clubListProvider.future),
            builder: (context, clubListSnapshot) {
              if (clubListSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (clubListSnapshot.hasError) {
                return Text('동아리 목록을 불러올 수 없어요', style: context.textTheme.bodyLarge);
              } else {
                final clubList = clubListSnapshot.data;

                return Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const Gap(defaultGapXL),
                    itemCount: clubList!.length + 1,
                    itemBuilder: (context, index) {
                      if (index != clubList.length) {
                        final club = clubList[index];
                        final isCurrent = club.clubId == currentClubId;
                        final CachedNetworkImageProvider imageProvider = CachedNetworkImageProvider(club.clubImage!);

                        return SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: InkWell(
                            onTap: () async {
                              await ref.read(clubIdProvider.notifier).saveClubId(club.clubId!);

                              if (context.mounted) {
                                _pushRoutePage(context, club.clubName!);
                              }
                            },
                            child: Ink(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: context.colorScheme.surfaceContainer,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: context.colorScheme.surfaceContainer,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 18,
                                      backgroundImage: imageProvider,
                                    ),
                                  ),
                                  const Gap(defaultGapXL),
                                  Text(
                                    club.clubName!,
                                    style: context.textTheme.bodyLarge,
                                  ),
                                  const Spacer(),
                                  if (isCurrent)
                                    Icon(
                                      size: 20,
                                      Symbols.check_circle_rounded,
                                      color: context.colorScheme.primary,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: InkWell(
                            onTap: () => _pushClubRegisterCautionPage(context),
                            child: Ink(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: context.colorScheme.surfaceContainer,
                                    ),
                                    child: Center(
                                      child: Icon(Symbols.add_rounded, color: context.colorScheme.outline),
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
                        );
                      }
                    },
                  ),
                );
              }
            },
          ),
        ],
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

  void _pushRoutePage(BuildContext context, String clubName) {
    Navigator.of(context).pop();

    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        pageBuilder: (
          context,
          Animation<double> animation1,
          Animation<double> animation2,
        ) =>
            const RoutePage(),
      ),
      (route) => false,
    );

    GeneralFunctions.generalToastMessage('$clubName 동아리로 전환되었어요');
  }
}
