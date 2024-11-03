import 'package:dio/dio.dart';
import 'package:woohakdong/service/dio/dio_service.dart';
import 'package:woohakdong/service/logger/logger.dart';

import '../../model/club_member/club_member_me.dart';

class ClubMemberMeRepository {
  final Dio _dio = DioService().dio;

  Future<ClubMemberMe> getClubMemberMe(int clubId) async {
    try {
      logger.i('동아리 내 나의 정보 조회 시도');

      final response = await _dio.get('/clubs/$clubId/members/me');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;

        return ClubMemberMe.fromJson(jsonData);
      }

      throw Exception();
    } catch (e) {
      logger.e('동아리 내 나의 정보 조회 실패', error: e);
      throw Exception();
    }
  }
}
