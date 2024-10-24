import 'package:dio/dio.dart';

import '../../model/club/club_account.dart';
import '../../service/dio/dio_service.dart';
import '../../service/logger/logger.dart';

class ClubAccountRepository {
  final Dio _dio = DioService().dio;

  Future<ClubAccount> clubAccountValidation(ClubAccount clubAccount) async {
    try {
      logger.i('동아리 계좌 유효성 검증 시도');

      final response = await _dio.post(
        '/clubs/accounts/validate',
        data: clubAccount.toJsonForValidation(),
      );

      if (response.statusCode == 200) {
        return ClubAccount.fromJson(response.data);
      } else {
        throw Exception();
      }
    } catch (e) {
      logger.e('동아리 계좌 유효성 검증 실패', error: e);
      throw Exception();
    }
  }

  Future<void> clubAccountRegister(int clubId, ClubAccount clubAccount) async {
    try {
      logger.i('동아리 계좌 등록 시도');

      _dio.post(
        '/clubs/$clubId/accounts',
        data: clubAccount.toJsonForRegister(),
      );
    } catch (e) {
      logger.e('동아리 계좌 등록 실패', error: e);
      throw Exception();
    }
  }
}
