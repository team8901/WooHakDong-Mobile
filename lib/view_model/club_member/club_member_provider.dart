import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/view_model/club/club_id_provider.dart';

import '../../model/club_member/club_member.dart';
import '../../repository/club_member/club_member_repository.dart';

final clubMemberProvider = StateNotifierProvider<ClubMemberNotifier, ClubMember>((ref) {
  return ClubMemberNotifier(ref);
});

class ClubMemberNotifier extends StateNotifier<ClubMember> {
  final Ref ref;
  final ClubMemberRepository clubMemberRepository = ClubMemberRepository();

  ClubMemberNotifier(this.ref) : super(ClubMember());

  Future<List<ClubMember>> getClubMemberList(DateTime? clubMemberAssignedTerm) async {
    final currentClubId = ref.watch(clubIdProvider);

    final List<ClubMember> clubMemberList = await clubMemberRepository.getClubMemberList(
      currentClubId!,
      clubMemberAssignedTerm,
    );

    return clubMemberList;
  }

  Future<List> getClubMemberTermList() async {
    final currentClubId = ref.watch(clubIdProvider);

    final List clubMemberTermList = await clubMemberRepository.getClubMemberTermList(
      currentClubId!,
    );

    return clubMemberTermList;
  }
}
