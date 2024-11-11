import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/club_member/club_member_term.dart';
import 'package:woohakdong/repository/club_member/club_member_term_repository.dart';

import '../club/club_id_provider.dart';

final clubMemberTermProvider = StateNotifierProvider<ClubMemberTermNotifier, ClubMemberTerm>((ref) {
  return ClubMemberTermNotifier(ref);
});

class ClubMemberTermNotifier extends StateNotifier<ClubMemberTerm> {
  final Ref ref;
  final ClubMemberTermRepository clubMemberRepository = ClubMemberTermRepository();

  ClubMemberTermNotifier(this.ref) : super(ClubMemberTerm());

  Future<List<ClubMemberTerm>> getClubMemberTermList() async {
    final currentClubId = ref.read(clubIdProvider);

    final List<ClubMemberTerm> clubMemberTermList = await clubMemberRepository.getClubMemberTermList(currentClubId!);

    return clubMemberTermList;
  }
}
