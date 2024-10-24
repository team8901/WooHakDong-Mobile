import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../view_model/auth/auth_provider.dart';
import '../../view_model/club/current_club_provider.dart';
import '../themes/spacing.dart';
import 'components/club_information_bottom_sheet.dart';

class ClubInformationPage extends ConsumerWidget {
  const ClubInformationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clubInfo = ref.watch(currentClubProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            showModalBottomSheet(
              useSafeArea: true,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultBorderRadiusL)),
              showDragHandle: true,
              backgroundColor: context.colorScheme.surfaceDim,
              context: context,
              builder: (context) {
                return const ClubInformationBottomSheet();
              },
            );
          },
          child: Row(
            children: [
              Text(clubInfo?.clubName ?? '내 동아리'),
              const Gap(defaultGapS),
              const Icon(
                Symbols.keyboard_arrow_down_rounded,
                size: 20,
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              authNotifier.signOut();
            },
            icon: const Icon(Symbols.settings_rounded),
          ),
        ],
      ),
    );
  }
}
