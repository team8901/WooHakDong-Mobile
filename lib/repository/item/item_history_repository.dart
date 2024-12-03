import 'package:dio/dio.dart';
import 'package:woohakdong/model/item/item_history.dart';
import 'package:woohakdong/service/dio/dio_service.dart';
import 'package:woohakdong/service/logger/logger.dart';

class ItemHistoryRepository {
  final Dio _dio = DioService().dio;

  Future<List<ItemHistory>> getItemHistoryList(int clubId, int itemId) async {
    try {
      logger.i('물품 대여 내역 목록 조회 시도');

      final response = await _dio.get(
        '/clubs/$clubId/items/$itemId/history',
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;

        List<dynamic> itemHistoryListData = jsonData['result'] as List<dynamic>;

        return itemHistoryListData.map((json) => ItemHistory.fromJson(json as Map<String, dynamic>)).toList();
      }

      throw Exception();
    } catch (e) {
      logger.e('물품 대여 내역 목록 조회 실패', error: e);
      throw Exception();
    }
  }

  Future<List<ItemHistory>> getItemHistoryListByMember(int clubId, int clubMemberId) async {
    try {
      logger.i('회원의 물품 대여 내역 목록 조회 시도');

      final response = await _dio.get(
        '/clubs/$clubId/items/history/$clubMemberId',
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;

        List<dynamic> itemHistoryListDataByMember = jsonData['result'] as List<dynamic>;

        return itemHistoryListDataByMember.map((json) => ItemHistory.fromJson(json as Map<String, dynamic>)).toList();
      }

      throw Exception();
    } catch (e) {
      logger.e('회원의 물품 대여 내역 목록 조회 실패', error: e);
      throw Exception();
    }
  }

  Future<List<ItemHistory>> getEntireItemHistoryList(int clubId) async {
    try {
      logger.i('전체 물품 대여 내역 조회 시도');

      final response = await _dio.get(
        '/clubs/$clubId/items/history',
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;

        List<dynamic> itemEntireHistoryListData = jsonData['result'] as List<dynamic>;

        return itemEntireHistoryListData.map((json) => ItemHistory.fromJson(json as Map<String, dynamic>)).toList();
      }

      throw Exception();
    } catch (e) {
      logger.e('전체 물품 대여 내역 조회 실패', error: e);
      throw Exception();
    }
  }
}
