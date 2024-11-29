import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/club_member/club_member.dart';
import '../../repository/club_member/club_member_repository.dart';
import '../club/club_id_provider.dart';
import '../club_member/components/club_selected_term_provider.dart';

final delegateClubMemberSearchProvider = FutureProvider.autoDispose.family<List<ClubMember>, String>((ref, name) async {
  final currentClubId = ref.read(clubIdProvider);
  final clubMemberAssignedTerm = ref.read(clubSelectedTermProvider);
  final ClubMemberRepository clubMemberRepository = ClubMemberRepository();

  final delegateClubMemberSearchedList = await clubMemberRepository.getClubMemberList(
    currentClubId!,
    clubMemberAssignedTerm,
    name,
  );

  return delegateClubMemberSearchedList;
});
