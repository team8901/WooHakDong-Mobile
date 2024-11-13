import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/club_info/components/club_info_action_buitton.dart';
import 'package:woohakdong/view/club_info/components/club_info_box.dart';
import 'package:woohakdong/view/setting/setting_page.dart';
import 'package:woohakdong/view_model/club/club_list_provider.dart';

import '../../view_model/club/current_club_info_provider.dart';
import '../themes/spacing.dart';
import 'components/club_info_bottom_sheet.dart';

class ClubInfoPage extends ConsumerWidget {
  const ClubInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentClubInfo = ref.watch(currentClubInfoProvider);

    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () async {
            await ref.read(clubListProvider.notifier).getClubList();

            if (context.mounted) {
              showModalBottomSheet(
                useSafeArea: true,
                context: context,
                builder: (context) => const ClubInfoBottomSheet(),
              );
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: Text(currentClubInfo.clubName ?? '내 동아리', softWrap: false)),
              const Gap(defaultGapS / 2),
              const Icon(
                Symbols.keyboard_arrow_down_rounded,
                size: 20,
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _pushSettingPage(context),
            icon: const Icon(Symbols.settings_rounded),
          ),
        ],
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(defaultPaddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClubInfoBox(),
              Gap(defaultGapXL),
              ClubInfoActionButton(),
            ],
          ),
        ),
      ),
    );
  }

  void _pushSettingPage(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const SettingPage(),
      ),
    );
  }
}
