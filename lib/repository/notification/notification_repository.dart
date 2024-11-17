import 'package:dio/dio.dart';

import '../../service/dio/dio_service.dart';
import '../../service/logger/logger.dart';

class NotificationRepository {
  final Dio _dio = DioService().dio;

  Future<void> sendClubInfoNotification(int clubId) async {
    try {
      logger.i('동아리 정보 알림 전송 시도');

      final response = await _dio.post(
        '/clubs/$clubId/notifications/clubs',
      );

      if (response.statusCode == 200) {
        return;
      }

      throw Exception();
    } catch (e) {
      logger.e('동아리 정보 알림 전송 실패', error: e);
      throw Exception();
    }
  }

  Future<void> sendClubScheduleNotification(int clubId, int scheduleId) async {
    try {
      logger.i('동아리 일정 알림 전송 시도');

      final response = await _dio.post(
        '/clubs/$clubId/notifications/schedules/$scheduleId',
      );

      if (response.statusCode == 200) {
        return;
      }

      throw Exception();
    } catch (e) {
      logger.e('동아리 일정 알림 전송 실패', error: e);
      throw Exception();
    }
  }
}
