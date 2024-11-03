import 'package:dio/dio.dart';
import 'package:woohakdong/model/item/item.dart';
import 'package:woohakdong/service/logger/logger.dart';

import '../../service/dio/dio_service.dart';

class ItemRepository {
  final Dio _dio = DioService().dio;

  Future<List<Item>> getItemList(int clubId) async {
    try {
      logger.i('물품 목록 조회 시도');

      final response = await _dio.get('/clubs/$clubId/items');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;

        List<dynamic> itemListData = jsonData['result'] as List<dynamic>;

        return itemListData.map((json) => Item.fromJson(json as Map<String, dynamic>)).toList();
      }

      throw Exception();
    } catch (e) {
      logger.e('물품 목록 조회 실패', error: e);
      throw Exception();
    }
  }

  Future<Map<String, dynamic>> addItem(int clubId, Item item) async {
    try {
      logger.i('물품 추가 시도');

      final response = await _dio.post(
        '/clubs/$clubId/items',
        data: item.toJson(),
      );

      if (response.statusCode == 200) {
        return {
          'itemId': response.data['itemId'],
          'itemName': response.data['itemName'],
        };
      }

      throw Exception();
    } catch (e) {
      logger.e('물품 추가 실패', error: e);
      throw Exception();
    }
  }
}
