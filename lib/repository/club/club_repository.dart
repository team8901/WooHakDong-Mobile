import 'package:dio/dio.dart';
import 'package:woohakdong/model/club/club.dart';

import '../../service/dio/dio_service.dart';
import '../../service/logger/logger.dart';

class ClubRepository {
  final Dio _dio = DioService().dio;

  Future<bool> clubNameValidation(String clubName, String clubEnglishName) async {
    try {
      logger.i('동아리 이름 유효성 검증 시도');

      final response = await _dio.post(
        '/clubs/validate',
        data: {
          'clubName': clubName,
          'clubEnglishName': clubEnglishName,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        logger.e('서버 에러');
        return false;
      }
    } catch (e) {
      logger.e('동아리 이름 유효성 검증 실패', error: e);
      return false;
    }
  }

  Future<int?> registerClubInfo(Club club) async {
    try {
      logger.i('동아리 등록 시도');

      final response = await _dio.post(
        '/clubs',
        data: club.toJson(),
      );

      if (response.statusCode == 200) {
        return response.data['clubId'];
      } else {
        return null;
      }
    } catch (e) {
      logger.e('동아리 등록 실패', error: e);
      return null;
    }
  }

  Future<List<Club>> getClubList() async {
    try {
      logger.i('동아리 목록 조회 시도');

      final response = await _dio.get('/clubs');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;

        List<dynamic> clubListData = jsonData['result'] as List<dynamic>;

        return clubListData.map((json) => Club.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw Exception();
      }
    } catch (e) {
      logger.e('동아리 목록 조회 실패', error: e);
      rethrow;
    }
  }
}
