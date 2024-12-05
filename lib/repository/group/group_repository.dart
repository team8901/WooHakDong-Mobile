import 'package:dio/dio.dart';

import '../../model/group/group.dart';
import '../../service/dio/dio_service.dart';
import '../../service/logger/logger.dart';

class GroupRepository {
  final Dio _dio = DioService().dio;

  Future<Group> getClubRegisterInfo(int clubId) async {
    try {
      logger.i('동아리 가입 페이지 정보 조회 시도');

      final response = await _dio.get('/clubs/$clubId/join');

      if (response.statusCode == 200) {
        return Group.fromJsonForPromotion(response.data);
      }

      throw Exception();
    } catch (e) {
      logger.e('동아리 가입 페이지 정보 조회 실패', error: e);
      throw Exception();
    }
  }

  Future<List<Group>> getGroupList(int clubId) async {
    try {
      logger.i('모임 목록 조회 시도');

      final response = await _dio.get('/clubs/$clubId/groups');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;

        List<dynamic> groupListData = jsonData['result'] as List<dynamic>;

        return groupListData.map((json) => Group.fromJson(json as Map<String, dynamic>)).toList();
      }

      throw Exception();
    } catch (e) {
      logger.e('모임 목록 조회 실패');
      throw Exception();
    }
  }

  Future<Group> getGroupInfo(int groupId) async {
    try {
      logger.i('모임 상세 정보 조회 시도');

      final response = await _dio.get('/groups/$groupId');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;

        return Group.fromJson(jsonData);
      }

      throw Exception();
    } catch (e) {
      logger.e('모임 상세 정보 조회 실패');
      throw Exception();
    }
  }

  Future<int> addGroup(int clubId, Group group) async {
    try {
      logger.i('모임 추가 시도');

      final response = await _dio.post(
        '/clubs/$clubId/groups',
        data: group.toJsonForAdd(),
      );

      if (response.statusCode == 200) {
        return response.data['groupId'];
      }

      throw Exception();
    } catch (e) {
      logger.e('모임 추가 실패');
      throw Exception();
    }
  }

  Future<int> updateGroup(int groupId, Group group) async {
    try {
      logger.i('모임 수정 시도');

      final response = await _dio.put('/groups/$groupId', data: group.toJsonForUpdate());

      if (response.statusCode == 200) {
        return response.data['groupId'];
      }

      throw Exception();
    } catch (e) {
      logger.e('모임 수정 실패');
      throw Exception();
    }
  }

  Future<void> deleteGroup(int groupId) async {
    try {
      logger.i('모임 삭제 시도');

      final response = await _dio.delete('/groups/$groupId');

      if (response.statusCode == 200) {
        return;
      }

      throw Exception();
    } catch (e) {
      logger.e('모임 삭제 실패');
      throw Exception();
    }
  }
}
