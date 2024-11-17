import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/repository/dues/dues_repository.dart';

import '../../model/dues/dues.dart';
import '../club/club_id_provider.dart';

final duesListProvider = StateNotifierProvider.family<DuesListNotifier, AsyncValue<List<Dues>>, String?>((ref, date) {
  return DuesListNotifier(ref, date);
});

class DuesListNotifier extends StateNotifier<AsyncValue<List<Dues>>> {
  final Ref ref;
  final String? date;
  final DuesRepository duesRepository = DuesRepository();

  DuesListNotifier(this.ref, this.date) : super(const AsyncValue.loading()) {
    getDuesList(date);
  }

  Future<void> getDuesList(String? date) async {
    try {
      final currentClubId = ref.read(clubIdProvider);

      state = const AsyncValue.loading();

      final duesList = await duesRepository.getDuesList(currentClubId!, date);

      state = AsyncValue.data(duesList);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> refreshDuesList() async {
    try {
      final currentClubId = ref.read(clubIdProvider);

      await duesRepository.refreshDuesList(currentClubId!);
    } catch (e) {
      rethrow;
    }
  }
}
