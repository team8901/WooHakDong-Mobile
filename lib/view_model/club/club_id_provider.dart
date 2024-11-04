import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final clubIdProvider = StateNotifierProvider<ClubIdNotifier, int?>((ref) {
  return ClubIdNotifier();
});

class ClubIdNotifier extends StateNotifier<int?> {
  ClubIdNotifier() : super(null) {
    _loadSavedClubId();
  }

  Future<void> _loadSavedClubId() async {
    final prefs = await SharedPreferences.getInstance();
    final savedClubId = prefs.getInt('currentClubId');
    state = savedClubId;
  }

  Future<void> saveClubId(int clubId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentClubId', clubId);
    state = clubId;
  }
}
