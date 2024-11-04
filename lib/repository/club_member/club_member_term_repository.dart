import 'package:dio/dio.dart';
import 'package:woohakdong/model/club_member/club_member_term.dart';

import '../../service/dio/dio_service.dart';
import '../../service/logger/logger.dart';

class ClubMemberTermRepository {
  final Dio _dio = DioService().dio;

  Future<List<ClubMemberTerm>> getClubMemberTermList(int clubId) async {
    try {
      logger.i('동아리 가입 기수 리스트 조회 시도');

      final response = await _dio.get('/clubs/$clubId/terms');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;

        List<dynamic> clubMemberTermListData = jsonData['result'] as List<dynamic>;

        return clubMemberTermListData.map((json) => ClubMemberTerm.fromJson(json as Map<String, dynamic>)).toList();

      }

      throw Exception();
    } catch (e) {
      logger.e('동아리 가입 기수 리스트 조회 실패', error: e);
      throw Exception();
    }
  }
}
