import 'package:dio/dio.dart';
import 'package:woohakdong/model/schedule/schedule.dart';
import 'package:woohakdong/service/dio/dio_service.dart';
import 'package:woohakdong/service/logger/logger.dart';

class ScheduleRepository {
  final Dio _dio = DioService().dio;

  Future<List<Schedule>> getSchedule(int clubId, String? date) async {
    try {
      logger.i('일정 목록 조회 시도');

      final response = await _dio.get(
        '/clubs/$clubId/schedules',
        queryParameters: date != null ? {'date': date} : {},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;

        List<dynamic> scheduleListDate = jsonData['result'] as List<dynamic>;

        return scheduleListDate.map((json) => Schedule.fromJson(json as Map<String, dynamic>)).toList();
      }

      throw Exception();
    } catch (e) {
      logger.e('일정 목록 조회 실패', error: e);
      throw Exception();
    }
  }

  Future<Schedule> getScheduleInfo(int clubId, int scheduleId) async {
    try {
      logger.i('일정 상세 정보 조회 시도');

      final response = await _dio.get('/clubs/$clubId/schedules/$scheduleId');

      if (response.statusCode == 200) {
        return Schedule.fromJson(response.data);
      }
      throw Exception();
    } catch (e) {
      logger.e('일정 상세 정보 조회 실패', error: e);
      throw Exception();
    }
  }

  Future<void> addSchedule(int clubId, Schedule scheduleInfo) async {
    try {
      logger.i('일정 추가 시도');

      await _dio.post(
        '/clubs/$clubId/schedules',
        data: scheduleInfo.toJson(),
      );
    } catch (e) {
      logger.e('일정 추가 실패', error: e);
      throw Exception();
    }
  }

  Future<int> updateSchedule(int clubId, int scheduleId, Schedule updatedScheduleInfo) async {
    try {
      logger.i('일정 수정 시도');

      final response = await _dio.put(
        '/clubs/$clubId/schedules/$scheduleId',
        data: updatedScheduleInfo.toJson(),
      );

      if (response.statusCode == 200) {
        return response.data['scheduleId'];
      }

      throw Exception();
    } catch (e) {
      logger.e('일정 수정 실패', error: e);
      throw Exception();
    }
  }

  Future<void> deleteSchedule(int clubId, int scheduleId) async {
    try {
      logger.i('일정 삭제 시도');

      await _dio.delete(
        '/clubs/$clubId/schedules/$scheduleId',
      );
    } catch (e) {
      logger.e('일정 삭제 실패', error: e);
      throw Exception();
    }
  }
}
