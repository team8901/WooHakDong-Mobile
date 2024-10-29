import 'package:dio/dio.dart';
import 'package:woohakdong/model/club_member/club_member.dart';
import 'package:woohakdong/service/dio/dio_service.dart';
import 'package:woohakdong/service/logger/logger.dart';

class ClubMemberRepository {
  final Dio _dio = DioService().dio;

  Future<List<ClubMember>> getClubMemberList(int clubId, String? clubMemberAssignedTerm) async {
    try {
      logger.i('동아리 회원 목록 조회 시도');

      final response = await _dio.get(
        '/club/$clubId/members',
        queryParameters: clubMemberAssignedTerm != null
            ? {'clubMemberAssignedTerm': clubMemberAssignedTerm}
            : {},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;

        List<dynamic> clubMemberListData = jsonData['result'] as List<dynamic>;

        return clubMemberListData.map((json) => ClubMember.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw Exception();
      }
    } catch (e) {
      logger.e('동아리 회원 목록 조회 실패', error: e);
      throw Exception();
    }
  }

  Future<List> getClubMemberTermList(int clubId) async {
    try {
      logger.i('동아리 가입 기수 리스트 조회 시도');

      final response = await _dio.get('/v1/clubs/$clubId/terms');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;

        List<dynamic> clubTermListData = jsonData['result'] as List<dynamic>;

        return clubTermListData.map((json) => json['clubHistoryUsageDate']).toList();
      } else {
        throw Exception();
      }
    } catch (e) {
      logger.e('동아리 가입 기수 리스트 조회 실패', error: e);
      throw Exception();
    }
  }
}
