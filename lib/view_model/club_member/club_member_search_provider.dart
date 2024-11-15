import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/club_member/club_member.dart';
import 'package:woohakdong/repository/club_member/club_member_repository.dart';

import '../club/club_id_provider.dart';
import 'components/club_selected_term_provider.dart';

final clubMemberSearchProvider = FutureProvider.autoDispose.family<List<ClubMember>, String>((ref, name) async {
  if (name.isEmpty) return [];

  final currentClubId = ref.read(clubIdProvider);
  final clubMemberAssignedTerm = ref.read(clubSelectedTermProvider);
  final ClubMemberRepository clubMemberRepository = ClubMemberRepository();

  final clubMemberSearchedList = await clubMemberRepository.getClubMemberList(
    currentClubId!,
    clubMemberAssignedTerm,
    name,
  );

  return clubMemberSearchedList;
});
