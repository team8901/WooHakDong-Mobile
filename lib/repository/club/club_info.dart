import 'package:dio/dio.dart';
import 'package:woohakdong/model/club/club.dart';

import '../../service/dio/dio_service.dart';
import '../../service/logger/logger.dart';

class ClubInfo {
  final Dio _dio = DioService().dio;

  Future<bool> clubNameValidation(String clubName, String clubEnglishName) async {
    try {
      final response = await _dio.post(
        '/clubs/validate',
        data: {
          'clubName': clubName,
          'clubEnglishName': clubEnglishName,
        },
      );

      if (response.statusCode == 200) {
        logger.i('동아리 이름 사용 가능');
        return true;
      } else if (response.statusCode == 400) {
        logger.i('동아리 이름 중복');
        return false;
      } else {
        logger.e('서버 에러');
        return false;
      }
    } catch (e) {
      logger.e('동아리 이름 유효성 검증 실패', error: e);
      return false;
    }
  }

  Future<void> registerClubInfo(Club club) async {
    try {
      final response = await _dio.post(
        '/clubs',
        data: club.toJson(),
      );

      if (response.statusCode == 200) {
        logger.i('동아리 등록 성공');
      } else {
        logger.e('서버 에러', error: response.data);
        throw Exception();
      }
    } catch (e) {
      logger.e('동아리 등록 실패', error: e);
      throw Exception();
    }
  }
}
