import 'package:dio/dio.dart';
import 'package:woohakdong/model/group/group_member.dart';

import '../../service/dio/dio_service.dart';
import '../../service/logger/logger.dart';

class GroupMemberRepository {
  final Dio _dio = DioService().dio;

  Future<List<GroupMember>> getClubMemberList(int groupId) async {
    try {
      logger.i('그룹 참여 회원 조회 시도');

      final response = await _dio.get('/groups/$groupId/members');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;

        List<dynamic> groupMemberList = jsonData['result'] as List<dynamic>;

        return groupMemberList.map((json) => GroupMember.fromJson(json as Map<String, dynamic>)).toList();
      }

      throw Exception();
    } catch (e) {
      logger.e('그룹 참여 회원 조회 실패', error: e);
      throw Exception();
    }
  }
}
