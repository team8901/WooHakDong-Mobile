import 'package:dio/dio.dart';
import 'package:woohakdong/model/club_member/club_member.dart';
import 'package:woohakdong/service/dio/dio_service.dart';
import 'package:woohakdong/service/logger/logger.dart';

class ClubMemberRepository {
  final Dio _dio = DioService().dio;

  Future<List<ClubMember>> getClubMemberList(int clubId, String? clubMemberAssignedTerm, String? name) async {
    try {
      logger.i('동아리 회원 목록 조회 시도');

      final Map<String, dynamic> queryParams = {};

      if (clubMemberAssignedTerm != null && clubMemberAssignedTerm.isNotEmpty) {
        queryParams['clubMemberAssignedTerm'] = clubMemberAssignedTerm;
      }
      if (name != null && name.isNotEmpty) {
        queryParams['name'] = name;
      }

      final response = await _dio.get(
        '/clubs/$clubId/members',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;

        List<dynamic> clubMemberListData = jsonData['result'] as List<dynamic>;

        return clubMemberListData.map((json) => ClubMember.fromJson(json as Map<String, dynamic>)).toList();
      }

      throw Exception();
    } catch (e) {
      logger.e('동아리 회원 목록 조회 실패', error: e);
      throw Exception();
    }
  }

  Future<ClubMember> getClubMemberInfo(int clubId, int clubMemberId) async {
    try {
      logger.i('동아리 회원 상세 정보 조회 시도');

      final response = await _dio.get('/clubs/$clubId/members/$clubMemberId');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;

        return ClubMember.fromJson(jsonData);
      }

      throw Exception();
    } catch (e) {
      logger.e('동아리 회원 상세 정보 조회 실패', error: e);
      throw Exception();
    }
  }

  Future<ClubMember> getClubMemberMyInfo(int clubId) async {
    try {
      logger.i('동아리 내 나의 정보 조회 시도');

      final response = await _dio.get('/clubs/$clubId/members/me');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;

        return ClubMember.fromJson(jsonData);
      }

      throw Exception();
    } catch (e) {
      logger.e('동아리 내 나의 정보 조회 실패', error: e);
      throw Exception();
    }
  }

  Future<void> updateClubMemberRole(int clubId, int clubMemberId, String clubMemberRole) async {
    try {
      logger.i('동아리 회원 역할 수정 시도');

      await _dio.put(
        '/clubs/$clubId/members/$clubMemberId/role',
        queryParameters: {'clubMemberRole': clubMemberRole},
      );
    } catch (e) {
      logger.e('동아리 회원 역할 수정 실패', error: e);
      throw Exception();
    }
  }
}
