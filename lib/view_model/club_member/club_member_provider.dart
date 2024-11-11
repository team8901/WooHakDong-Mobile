import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/view_model/club/club_id_provider.dart';
import 'package:woohakdong/view_model/club_member/components/club_member_state_provider.dart';

import '../../model/club_member/club_member.dart';
import '../../repository/club_member/club_member_repository.dart';
import 'club_member_list_provider.dart';
import 'components/club_member_state.dart';

final clubMemberProvider = StateNotifierProvider<ClubMemberNotifier, ClubMember>((ref) {
  return ClubMemberNotifier(ref);
});

class ClubMemberNotifier extends StateNotifier<ClubMember> {
  final Ref ref;
  final ClubMemberRepository clubMemberRepository = ClubMemberRepository();

  ClubMemberNotifier(this.ref) : super(ClubMember());

  Future<void> getClubMemberInfo(int clubMemberId) async {
    final currentClubId = ref.read(clubIdProvider);

    final clubMemberInfo = await clubMemberRepository.getClubMemberInfo(currentClubId!, clubMemberId);

    state = clubMemberInfo;
  }

  Future<void> updateClubMemberRole(int clubMemberId, String clubMemberRole) async {
    try {
      ref.read(clubMemberStateProvider.notifier).state = ClubMemberState.editing;

      final currentClubId = ref.read(clubIdProvider);

      await clubMemberRepository.updateClubMemberRole(
        currentClubId!,
        clubMemberId,
        clubMemberRole,
      );

      await ref.read(clubMemberListProvider.notifier).getClubMemberList();
      await getClubMemberInfo(clubMemberId);

      ref.read(clubMemberStateProvider.notifier).state = ClubMemberState.edited;
    } catch (e) {
      ref.read(clubMemberStateProvider.notifier).state = ClubMemberState.initial;

      rethrow;
    }
  }
}
