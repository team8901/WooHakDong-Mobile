import 'package:dio/dio.dart';

import '../../model/club/current_club_account.dart';
import '../../service/dio/dio_service.dart';
import '../../service/logger/logger.dart';

class CurrentClubAccountRepository {
  final Dio _dio = DioService().dio;

  Future<CurrentClubAccount> getCurrentClubAccount(int clubId) async {
    try {
      logger.i('현재 동아리 계좌 정보 조회 시도');

      final response = await _dio.get('/clubs/$clubId/accounts');

      if (response.statusCode == 200) {
        return CurrentClubAccount.fromJson(response.data);
      }

      throw Exception();
    } catch (e) {
      logger.e('현재 동아리 계좌 정보 조회 실패', error: e);
      throw Exception();
    }
  }
}