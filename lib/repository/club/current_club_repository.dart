import 'package:dio/dio.dart';

import '../../model/club/current_club.dart';
import '../../service/dio/dio_service.dart';
import '../../service/logger/logger.dart';

class CurrentClubRepository {
  final Dio _dio = DioService().dio;

  Future<CurrentClub> getCurrentClubInfo(int clubId) async {
    try {
      logger.i('동아리 정보 조회 시도');

      final response = await _dio.get('/clubs/$clubId');

      if (response.statusCode == 200) {
        return CurrentClub.fromJson(response.data);
      }

      throw Exception();
    } catch (e) {
      logger.e('동아리 정보 조회 실패', error: e);
      throw Exception();
    }
  }

  Future<CurrentClub> updateCurrentClubInfo(CurrentClub currentClub, int clubId) async {
    try {
      logger.i('동아리 정보 수정 시도');

      final response = await _dio.put(
        '/clubs/$clubId',
        data: currentClub.toJson(),
      );

      if (response.statusCode == 200) {
        return CurrentClub.fromJson(response.data);
      }

      throw Exception();
    } catch (e) {
      logger.e('동아리 정보 수정 실패', error: e);
      throw Exception();
    }
  }
}
