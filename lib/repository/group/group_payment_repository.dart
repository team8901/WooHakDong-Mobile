import 'package:dio/dio.dart';

import '../../model/group/group.dart';
import '../../service/dio/dio_service.dart';
import '../../service/logger/logger.dart';

class GroupPaymentRepository {
  final Dio _dio = DioService().dio;

  Future<Group> getClubServiceFeeInfo(int clubId) async {
    try {
      logger.i('우학동 서비스 이용료 정보 확인 시도');

      final response = await _dio.get('/clubs/$clubId/payment-group');

      if (response.statusCode == 200) {
        return Group.fromJsonForPromotion(response.data);
      }

      throw Exception();
    } catch (e) {
      logger.e('우학동 서비스 이용료 정보 확인 실패', error: e);
      throw Exception();
    }
  }

  Future<int> getGroupPaymentOrderId(int groupId, String merchantUid) async {
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

  Future<void> confirmGroupPaymentOrder(int groupId, String merchantUid, String impUid, int orderId) async {
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
