import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:woohakdong/view/club_register/club_register_page.dart';
import 'package:woohakdong/view/member_register/member_register_page.dart';
import 'package:woohakdong/view/navigator_page.dart';
import 'package:woohakdong/view_model/club/club_id_provider.dart';
import 'package:woohakdong/view_model/club/club_provider.dart';
import 'package:woohakdong/view_model/club/components/club_state.dart';
import 'package:woohakdong/view_model/club/components/club_state_provider.dart';
import 'package:woohakdong/view_model/club/current_club_info_provider.dart';
import 'package:woohakdong/view_model/club_member/club_member_me_provider.dart';
import 'package:woohakdong/view_model/club_member/club_member_term_provider.dart';
import 'package:woohakdong/view_model/member/components/member_state.dart';
import 'package:woohakdong/view_model/member/components/member_state_provider.dart';
import 'package:woohakdong/view_model/member/member_provider.dart';
import 'package:woohakdong/view_model/util/s3_image_provider.dart';

import '../model/club/club.dart';
import '../view_model/club_member/components/club_selected_term_provider.dart';

class RoutePage extends ConsumerStatefulWidget {
  const RoutePage({super.key});

  @override
  ConsumerState<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends ConsumerState<RoutePage> {
  late Future<void> _initialization;

  @override
  void initState() {
    super.initState();
    _initialization = _initializeApp();
  }

  Future<void> _initializeApp() async {
    await ref.read(memberProvider.notifier).getMemberInfo();
    List<Club> clubList = await ref.read(clubProvider.notifier).getClubList();

    if (clubList.isNotEmpty) {
      final currentClubId = ref.watch(clubIdProvider);
      if (currentClubId == null) {
        await ref.read(clubIdProvider.notifier).saveClubId(clubList[0].clubId!);
      }

      await ref.read(currentClubInfoProvider.notifier).getCurrentClubInfo();

      final clubHistoryUsageDate = await ref.read(clubMemberTermProvider.notifier).getClubMemberTermList();

      if (clubHistoryUsageDate.isNotEmpty) {
        final selectedTerm = DateFormat('yyyy-MM-dd').format(
          clubHistoryUsageDate[clubHistoryUsageDate.length - 1].clubHistoryUsageDate!,
        );

        ref.read(clubSelectedTermProvider.notifier).state = selectedTerm;
      }

      await ref.read(clubMemberMeProvider.notifier).getClubMemberMe();
    }

    ref.invalidate(s3ImageProvider);
  }

  @override
  Widget build(BuildContext context) {
    final memberState = ref.watch(memberStateProvider);
    final clubState = ref.watch(clubStateProvider);

    return FutureBuilder(
      future: _initialization,
      builder: (context, infoSnapshot) {
        if (infoSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold();
        } else {
          if (memberState == MemberState.memberNotRegistered) {
            return const MemberRegisterPage();
          } else if (memberState == MemberState.memberRegistered) {
            if (clubState == ClubState.clubNotRegistered) {
              return const ClubRegisterPage();
            } else {
              return const NavigatorPage();
            }
          } else {
            return const Scaffold();
          }
        }
      },
    );
  }
}
