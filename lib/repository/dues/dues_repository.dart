import 'package:dio/dio.dart';
import 'package:woohakdong/model/dues/dues.dart';
import 'package:woohakdong/service/dio/dio_service.dart';
import 'package:woohakdong/service/logger/logger.dart';

class DuesRepository {
  final Dio _dio = DioService().dio;

  Future<List<Dues>> getDuesList(int clubId, String? date, String? keyword) async {
    try {
      logger.i('회비 내역 조회 시도');

      final Map<String, dynamic> queryParams = {};

      if (date != null && date.isNotEmpty) {
        queryParams['date'] = date;
      }
      if (keyword != null && keyword.isNotEmpty) {
        queryParams['keyword'] = keyword;
      }

      final response = await _dio.get(
        '/clubs/$clubId/dues',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;

        List<dynamic> duesListData = jsonData['result'] as List<dynamic>;

        return duesListData.map((json) => Dues.fromJson(json as Map<String, dynamic>)).toList();
      }

      throw Exception();
    } catch (e) {
      logger.e('회비 내역 조회 실패', error: e);
      throw Exception();
    }
  }

  Future<void> refreshDuesList(int clubId) async {
    try {
      logger.i('회비 내역 갱신 시도');

      await _dio.post('/clubs/$clubId/dues/update');
    } catch (e) {
      logger.e('회비 내역 갱신 실패', error: e);
      throw Exception();
    }
  }
}
