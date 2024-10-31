import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/club/club_account.dart';
import 'package:woohakdong/repository/club/club_account_repository.dart';

import 'components/club_account_validation_provider.dart';
import 'components/club_account_validation_state.dart';

final clubAccountProvider = StateNotifierProvider<ClubAccountNotifier, ClubAccount>((ref) {
  return ClubAccountNotifier(ref);
});

class ClubAccountNotifier extends StateNotifier<ClubAccount> {
  final Ref ref;
  final ClubAccountRepository clubAccountRepository = ClubAccountRepository();

  ClubAccountNotifier(this.ref)
      : super(
          ClubAccount(
            clubAccountBankName: '',
            clubAccountNumber: '',
            clubAccountPinTechNumber: '',
          ),
        );

  Future<void> saveClubAccountInfo(String clubAccountBankName, String clubAccountNumber) async {
    ref.read(clubAccountValidationProvider.notifier).state = ClubAccountValidationState.loading;

    await Future.delayed(const Duration(milliseconds: 750));

    try {
      ClubAccount validatedClubAccount = await clubAccountRepository.clubAccountValidation(
        state.copyWith(
          clubAccountBankName: clubAccountBankName,
          clubAccountNumber: clubAccountNumber,
        ),
      );

      state = validatedClubAccount;

      ref.read(clubAccountValidationProvider.notifier).state = ClubAccountValidationState.valid;
    } catch (e) {
      ref.read(clubAccountValidationProvider.notifier).state = ClubAccountValidationState.invalid;
      rethrow;
    }
  }

  Future<void> registerClubAccount(int? clubId) async {
    try {
      await clubAccountRepository.clubAccountRegister(clubId!, state);
    } catch (e) {
      rethrow;
    }
  }
}
