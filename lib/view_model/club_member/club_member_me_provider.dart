import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/repository/club_member/club_member_me_repository.dart';
import 'package:woohakdong/view_model/club/club_id_provider.dart';

import '../../model/club_member/club_member_me.dart';

final clubMemberMeProvider = StateNotifierProvider<ClubMemberMeNotifier, ClubMemberMe>((ref) {
  return ClubMemberMeNotifier(ref);
});

class ClubMemberMeNotifier extends StateNotifier<ClubMemberMe> {
  final Ref ref;
  final ClubMemberMeRepository clubMemberMeRepository = ClubMemberMeRepository();

  ClubMemberMeNotifier(this.ref) : super(ClubMemberMe());

  Future<void> getClubMemberMe() async {
    final currentClubId = ref.watch(clubIdProvider);

    final ClubMemberMe clubMemberMe = await clubMemberMeRepository.getClubMemberMe(currentClubId!);

    state = clubMemberMe;
  }
}
