import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/view_model/club/club_id_provider.dart';
import 'package:woohakdong/view_model/club_member/components/club_selected_term_provider.dart';

import '../../model/club_member/club_member.dart';
import '../../repository/club_member/club_member_repository.dart';

final clubMemberProvider = StateNotifierProvider<ClubMemberNotifier, ClubMember>((ref) {
  return ClubMemberNotifier(ref);
});

class ClubMemberNotifier extends StateNotifier<ClubMember> {
  final Ref ref;
  final ClubMemberRepository clubMemberRepository = ClubMemberRepository();

  ClubMemberNotifier(this.ref) : super(ClubMember());

  Future<List<ClubMember>> getClubMemberList() async {
    final currentClubId = ref.watch(clubIdProvider);
    final clubMemberAssignedTerm = ref.watch(clubSelectedTermProvider);

    final List<ClubMember> clubMemberList = await clubMemberRepository.getClubMemberList(
      currentClubId!,
      clubMemberAssignedTerm,
    );

    return clubMemberList;
  }

  Future<ClubMember> getClubMemberById(int clubMemberId) async {
    final List<ClubMember> clubMemberList = await getClubMemberList();

    final clubMember = clubMemberList.firstWhere((clubMember) => clubMember.clubMemberId == clubMemberId);

    return clubMember;
  }

  Future<void> updateClubMemberRole(int clubMemberId, String clubMemberRole) async {
    final currentClubId = ref.watch(clubIdProvider);

    try {
      await clubMemberRepository.updateClubMemberRole(
        currentClubId!,
        clubMemberId,
        clubMemberRole,
      );
    } catch (e) {
      rethrow;
    }
  }
}
