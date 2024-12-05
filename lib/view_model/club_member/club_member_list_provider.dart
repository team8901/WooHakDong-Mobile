import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/club_member/club_member.dart';

import '../../repository/club_member/club_member_repository.dart';
import '../club/club_id_provider.dart';
import 'components/club_member_count_provider.dart';
import 'components/club_member_sort_option.dart';
import 'components/club_member_sort_option_provider.dart';
import 'components/club_selected_term_provider.dart';

final clubMemberListProvider = StateNotifierProvider<ClubMemberListNotifier, AsyncValue<List<ClubMember>>>((ref) {
  return ClubMemberListNotifier(ref);
});

class ClubMemberListNotifier extends StateNotifier<AsyncValue<List<ClubMember>>> {
  final Ref ref;
  final ClubMemberRepository clubMemberRepository = ClubMemberRepository();

  ClubMemberListNotifier(this.ref) : super(const AsyncValue.loading()) {
    getClubMemberList();
  }

  Future<void> getClubMemberList() async {
    try {
      final currentClubId = ref.read(clubIdProvider);
      final clubMemberAssignedTerm = ref.read(clubSelectedTermProvider);
      final clubMemberSortOption = ref.watch(clubMemberSortOptionProvider);

      state = const AsyncValue.loading();

      final clubMemberList = await clubMemberRepository.getClubMemberList(
        currentClubId!,
        clubMemberAssignedTerm,
        null,
      );

      switch (clubMemberSortOption) {
        case ClubMemberSortOption.oldest:
          clubMemberList.sort((a, b) => a.clubMemberId!.compareTo(b.clubMemberId!));
          break;
        case ClubMemberSortOption.newest:
          clubMemberList.sort((a, b) => b.clubMemberId!.compareTo(a.clubMemberId!));
          break;
        case ClubMemberSortOption.nameAsc:
          clubMemberList.sort((a, b) => a.memberName!.compareTo(b.memberName!));
          break;
        case ClubMemberSortOption.nameDesc:
          clubMemberList.sort((a, b) => b.memberName!.compareTo(a.memberName!));
          break;
      }

      state = AsyncValue.data(clubMemberList);

      ref.read(clubMemberCountProvider.notifier).state = clubMemberList.length;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
