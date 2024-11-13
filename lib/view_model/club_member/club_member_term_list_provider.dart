import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/club_member/club_member_term.dart';
import 'package:woohakdong/repository/club_member/club_member_term_repository.dart';

import '../club/club_id_provider.dart';

final clubMemberTermListProvider = StateNotifierProvider<ClubMemberTermListNotifier, List<ClubMemberTerm>>((ref) {
  return ClubMemberTermListNotifier(ref);
});

class ClubMemberTermListNotifier extends StateNotifier<List<ClubMemberTerm>> {
  final Ref ref;
  final ClubMemberTermRepository clubMemberRepository = ClubMemberTermRepository();

  ClubMemberTermListNotifier(this.ref) : super([]);

  Future<void> getClubMemberTermList() async {
    try {
      final currentClubId = ref.watch(clubIdProvider);

      final clubMemberTermList = await clubMemberRepository.getClubMemberTermList(currentClubId!);

      state = clubMemberTermList;
    } catch (e) {
      rethrow;
    }
  }
}
