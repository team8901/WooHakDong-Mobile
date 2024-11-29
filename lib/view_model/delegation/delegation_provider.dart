import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/club_member/club_member.dart';

import '../../repository/club_member/club_member_repository.dart';
import '../club/club_id_provider.dart';
import '../club_member/components/club_member_state.dart';
import '../club_member/components/club_member_state_provider.dart';

final delegationProvider = StateNotifierProvider<DelegationNotifier, ClubMember>((ref) {
  return DelegationNotifier(ref);
});

class DelegationNotifier extends StateNotifier<ClubMember> {
  final Ref ref;
  final ClubMemberRepository clubMemberRepository = ClubMemberRepository();

  DelegationNotifier(this.ref) : super(ClubMember());

  Future<void> delegateClubPresident(int clubMemberId) async {
    try {
      ref.read(clubMemberStateProvider.notifier).state = ClubMemberState.editing;

      final currentClubId = ref.read(clubIdProvider);

      await clubMemberRepository.delegateClubPresident(currentClubId!, clubMemberId);

      ref.read(clubMemberStateProvider.notifier).state = ClubMemberState.edited;
    } catch (e) {
      ref.read(clubMemberStateProvider.notifier).state = ClubMemberState.initial;

      rethrow;
    }
  }
}
