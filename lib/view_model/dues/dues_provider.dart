import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/repository/dues/dues_repository.dart';

import '../../model/dues/dues.dart';
import '../club/club_id_provider.dart';

final duesProvider = StateNotifierProvider<DuesNotifier, Dues>((ref) => DuesNotifier(ref));

class DuesNotifier extends StateNotifier<Dues> {
  final Ref ref;
  final DuesRepository duesRepository = DuesRepository();

  DuesNotifier(this.ref) : super(Dues());

  Future<List<Dues>> getDuesList(String? date) async {
    final currentClubId = ref.watch(clubIdProvider);

    await Future.delayed(const Duration(milliseconds: 200));

    final List<Dues> duesList = await duesRepository.getDuesList(
      currentClubId!,
      date,
    );

    return duesList;
  }

  Future<void> refreshDuesList() async {
    try {
      final currentClubId = ref.watch(clubIdProvider);

      await duesRepository.refreshDuesList(currentClubId!);
    } catch (e) {
      rethrow;
    }
  }
}
