import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/club/club_provider.dart';

import '../../../service/general/general_functions.dart';
import '../../../view_model/club/club_id_provider.dart';
import '../../club_register/club_register_caution_page_.dart';
import '../../route_page.dart';
import '../../themes/spacing.dart';

class ClubInfoBottomSheet extends ConsumerWidget {
  const ClubInfoBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentClubId = ref.watch(clubIdProvider);

    return SizedBox(
      width: double.infinity,
      child: FutureBuilder(
        future: ref.watch(clubProvider.notifier).getClubList(),
        builder: (context, clubListSnapshot) {
          if (clubListSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (clubListSnapshot.hasError) {
            return Text('동아리 목록을 불러올 수 없어요', style: context.textTheme.bodyLarge);
          } else {
            final clubList = clubListSnapshot.data;

            return ListView.separated(
              padding: const EdgeInsets.only(bottom: defaultPaddingM),
              separatorBuilder: (context, index) => const Gap(defaultGapS),
              itemCount: clubList!.length + 2,
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
                  final CachedNetworkImageProvider imageProvider = CachedNetworkImageProvider(club.clubImage!);

                  return InkWell(
                    onTap: () async {
                      await ref.read(clubIdProvider.notifier).saveClubId(club.clubId!);

                      if (context.mounted) {
                        _pushRoutePage(context, club.clubName!);
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
                                border: Border.all(
                                  color: context.colorScheme.surfaceContainer,
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
                } else {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () => _pushClubRegisterCautionPage(context),
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
                      ),
                    ],
                  );
                }
              },
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

    GeneralFunctions.toastMessage('$clubName 동아리로 전환되었어요');
  }
}
