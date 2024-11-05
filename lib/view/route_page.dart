import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:woohakdong/service/general/general_functions.dart';
import 'package:woohakdong/view/club_register/club_register_account_form_page.dart';
import 'package:woohakdong/view/club_register/club_register_page.dart';
import 'package:woohakdong/view/member_register/member_register_page.dart';
import 'package:woohakdong/view/navigator_page.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_circular_progress_indicator.dart';
import 'package:woohakdong/view_model/club/club_id_provider.dart';
import 'package:woohakdong/view_model/club/club_provider.dart';
import 'package:woohakdong/view_model/club/components/club_account_validation_provider.dart';
import 'package:woohakdong/view_model/club/components/club_state.dart';
import 'package:woohakdong/view_model/club/components/club_state_provider.dart';
import 'package:woohakdong/view_model/club/current_club_account_info_provider.dart';
import 'package:woohakdong/view_model/club/current_club_info_provider.dart';
import 'package:woohakdong/view_model/club_member/club_member_me_provider.dart';
import 'package:woohakdong/view_model/club_member/club_member_term_provider.dart';
import 'package:woohakdong/view_model/member/components/member_state.dart';
import 'package:woohakdong/view_model/member/components/member_state_provider.dart';
import 'package:woohakdong/view_model/member/member_provider.dart';
import 'package:woohakdong/view_model/util/s3_image_provider.dart';

import '../model/club/club.dart';
import '../view_model/club/components/club_account_validation_state.dart';
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

      await ref.read(currentClubAccountInfoProvider.notifier).getCurrentClubAccountInfo();

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
    final clubAccountValidationState = ref.watch(clubAccountValidationProvider);

    return FutureBuilder(
      future: _initialization,
      builder: (context, infoSnapshot) {
        if (infoSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: SafeArea(child: CustomCircularProgressIndicator()));
        }

        if (memberState == MemberState.memberNotRegistered) {
          FlutterNativeSplash.remove();
          return const MemberRegisterPage();
        }

        if (clubState == ClubState.clubNotRegistered) {
          FlutterNativeSplash.remove();
          return const ClubRegisterPage();
        }

        if (clubAccountValidationState != ClubAccountValidationState.accountRegistered) {
          FlutterNativeSplash.remove();
          GeneralFunctions.toastMessage('동아리 회비 계좌를 등록하지 않으면\n우학동을 이용할 수 없어요');
          return const ClubRegisterAccountFormPage();
        }

        return const NavigatorPage();
      },
    );
  }
}
