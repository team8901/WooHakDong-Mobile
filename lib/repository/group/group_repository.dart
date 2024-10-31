import 'package:dio/dio.dart';

import '../../model/group/group.dart';
import '../../service/dio/dio_service.dart';
import '../../service/logger/logger.dart';

class GroupRepository {
  final Dio _dio = DioService().dio;

  Future<Group> getClubRegisterPageInfo(int clubId) async {
    try {
      logger.i('동아리 가입 페이지 정보 조회 시도');

      final response = await _dio.get('/clubs/$clubId/join');

      if (response.statusCode == 200) {
        return Group.fromJson(response.data);
      }

      throw Exception();
    } catch (e) {
      logger.e('동아리 가입 페이지 정보 조회 실패', error: e);
      throw Exception();
    }
  }
}
