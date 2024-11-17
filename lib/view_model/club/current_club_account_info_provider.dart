import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/repository/club/current_club_account_repository.dart';
import 'package:woohakdong/view_model/club/club_id_provider.dart';
import 'package:woohakdong/view_model/club/components/club_account_validation_provider.dart';

import '../../model/club/current_club_account.dart';
import 'components/club_account_validation_state.dart';

final currentClubAccountInfoProvider = StateNotifierProvider<CurrentClubAccountInfoNotifier, CurrentClubAccount>((ref) {
  return CurrentClubAccountInfoNotifier(ref);
});

class CurrentClubAccountInfoNotifier extends StateNotifier<CurrentClubAccount> {
  final Ref ref;
  final CurrentClubAccountRepository currentClubAccountRepository = CurrentClubAccountRepository();

  CurrentClubAccountInfoNotifier(this.ref) : super(CurrentClubAccount());

  Future<void> getCurrentClubAccountInfo() async {
    try {
      final currentClubId = ref.watch(clubIdProvider);
      final currentClubAccount = await currentClubAccountRepository.getCurrentClubAccount(currentClubId!);

      ref.read(clubAccountValidationProvider.notifier).state = ClubAccountValidationState.accountRegistered;

      state = currentClubAccount;
    } catch (e) {
      ref.read(clubAccountValidationProvider.notifier).state = ClubAccountValidationState.accountNotRegistered;

      rethrow;
    }
  }
}
