import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_circular_progress_indicator.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view_model/club_member/club_member_me_provider.dart';

import '../../view_model/club_member/club_member_provider.dart';
import 'components/club_member_detail_info.dart';
import 'components/club_member_role_edit_dialog.dart';

class ClubMemberDetailPage extends ConsumerWidget {
  final int clubMemberId;

  const ClubMemberDetailPage({
    super.key,
    required this.clubMemberId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clubMemberMe = ref.watch(clubMemberMeProvider);

    return FutureBuilder(
      future: ref.watch(clubMemberProvider.notifier).getClubMemberById(clubMemberId),
      builder: (context, clubMemberSnapshot) {
        if (clubMemberSnapshot.connectionState != ConnectionState.done) {
          return const Scaffold(body: CustomCircularProgressIndicator());
        }
        final clubMember = clubMemberSnapshot.data!;
        return Scaffold(
          appBar: AppBar(
            actions: [
              if (clubMemberMe.clubMemberRole == 'PRESIDENT' && clubMember.clubMemberRole != 'PRESIDENT')
                IconButton(
                  onPressed: () {
                    showDialog<String>(
                      context: context,
                      builder: (context) => ClubMemberRoleEditDialog(
                        currentClubMember: clubMember,
                        initialRole: clubMember.clubMemberRole,
                      ),
                    );
                  },
                  icon: const Icon(Symbols.settings_account_box_rounded),
                ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                top: defaultPaddingM * 2,
                left: defaultPaddingM,
                right: defaultPaddingM,
                bottom: defaultPaddingM,
              ),
              child: ClubMemberDetailInfo(clubMember: clubMember),
            ),
          ),
        );
      },
    );
  }
}
