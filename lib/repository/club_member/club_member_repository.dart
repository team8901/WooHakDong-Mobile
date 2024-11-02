import 'package:dio/dio.dart';
import 'package:woohakdong/model/club_member/club_member.dart';
import 'package:woohakdong/service/dio/dio_service.dart';
import 'package:woohakdong/service/logger/logger.dart';

class ClubMemberRepository {
  final Dio _dio = DioService().dio;

  Future<List<ClubMember>> getClubMemberList(int clubId, DateTime? clubMemberAssignedTerm) async {
    try {
      logger.i('동아리 회원 목록 조회 시도');

      final response = await _dio.get(
        '/clubs/$clubId/members',
        queryParameters:
            clubMemberAssignedTerm != null ? {'clubMemberAssignedTerm': clubMemberAssignedTerm.toIso8601String()} : {},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;

        List<dynamic> clubMemberListData = jsonData['result'] as List<dynamic>;

        return clubMemberListData.map((json) => ClubMember.fromJson(json as Map<String, dynamic>)).toList();
      }

      throw Exception();
    } catch (e) {
      logger.e('동아리 회원 목록 조회 실패', error: e);
      throw Exception('동아리 회원 목록 조회 실패');
    }
  }

  Future<List<DateTime>> getClubMemberTermList(int clubId) async {
    try {
      logger.i('동아리 가입 기수 리스트 조회 시도');

      final response = await _dio.get<Map<String, dynamic>>('/clubs/$clubId/terms');

      if (response.statusCode == 200) {
        final jsonData = response.data;

        if (jsonData != null && jsonData['result'] is List) {
          List<dynamic> clubTermListData = jsonData['result'];

          return clubTermListData.map((json) => DateTime.parse(json['clubHistoryUsageDate'] as String)).toList();
        } else {
          throw Exception('데이터 형식이 잘못되었습니다.');
        }
      }

      throw Exception();
    } catch (e) {
      logger.e('동아리 가입 기수 리스트 조회 실패', error: e);
      throw Exception('동아리 가입 기수 리스트 조회 실패');
    }
  }
}
