import 'package:dio/dio.dart';

import '../../model/group/group.dart';
import '../../service/dio/dio_service.dart';
import '../../service/logger/logger.dart';

class GroupRepository {
  final Dio _dio = DioService().dio;

  Future<Group> getClubRegisterPageInfo(int clubId) async {
    try {
      logger.i('동아리 가입 페이지 정보 조회 시도');

      final response = await _dio.get('/clubs/$clubId/join');

      if (response.statusCode == 200) {
        return Group.fromJson(response.data);
      }

      throw Exception();
    } catch (e) {
      logger.e('동아리 가입 페이지 정보 조회 실패', error: e);
      throw Exception();
    }
  }

  Future<Group> getServiceFeeGroupInfo(int clubId) async {
    try {
      logger.i('우학동 서비스 이용료 정보 확인 시도');

      final response = await _dio.get('/clubs/$clubId/payment-group');

      if (response.statusCode == 200) {
        return Group.fromJson(response.data);
      }

      throw Exception();
    } catch (e) {
      logger.e('우학동 서비스 이용료 정보 확인 실패', error: e);
      throw Exception();
    }
  }

  Future<int> getGroupOrderId(int groupId, String merchantUid) async {
    try {
      logger.i('우학동 서비스 결제를 위한 Order Id 조회 시도');

      final response = await _dio.post(
        '/groups/$groupId/orders',
        data: {
          'merchantUid': merchantUid,
        },
      );

      if (response.statusCode == 200) {
        return response.data['orderId'];
      }

      throw Exception();
    } catch (e) {
      logger.e('우학동 서비스 결제를 위한 Order Id 조회 실패', error: e);
      throw Exception();
    }
  }

  Future<void> confirmGroupOrder(int groupId, String merchantUid, String impUid, int orderId) async {
    try {
      logger.i('우학동 서비스 결제 완료 확인 시도');

      await _dio.post(
        '/groups/$groupId/orders/confirm',
        data: {
          'merchantUid': merchantUid,
          'impUid': impUid,
          'orderId': orderId,
        },
      );
    } catch (e) {
      logger.e('우학동 서비스 결제 완료 확인 실패', error: e);
      throw Exception();
    }
  }
}
