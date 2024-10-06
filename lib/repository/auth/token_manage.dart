import 'package:dio/dio.dart';

import '../../service/dio/dio_service.dart';
import '../../service/logger/logger.dart';

class TokenManage {
  final Dio _dio = DioService().dio;

  Future<Map<String, String>?> getToken(String googleAccessToken) async {
    try {
      final response = await _dio.post(
        '/auth/login/social',
        data: {
          'accessToken': googleAccessToken,
        },
      );

      if (response.statusCode == 200) {
        logger.i('토큰 발급 성공');
        return {
          'accessToken': response.data['accessToken'],
          'refreshToken': response.data['refreshToken'],
        };
      } else {
        logger.e('서버 에러', error: response.data);
        return null;
      }
    } catch (e) {
      logger.e('토큰 발급 실패', error: e);
      return null;
    }
  }

  Future<Map<String, String>?> getBackToken(String refreshToken) async {
    try {
      final response = await _dio.post(
        '/auth/refresh',
        data: {
          'refreshToken': refreshToken,
        },
      );

      if (response.statusCode == 200) {
        logger.i('토큰 재발급 성공');
        return {
          'accessToken': response.data['accessToken'],
          'refreshToken': response.data['refreshToken'],
        };
      } else {
        logger.e('서버 에러', error: response.data);
        return null;
      }
    } catch (e) {
      logger.e('토큰 재발급 실패', error: e);
      return null;
    }
  }

  Future<void> removeToken(String refreshToken) async {
    try {
      final response = await _dio.post(
        '/auth/logout',
        data: {
          'refreshToken': refreshToken,
        },
      );

      if (response.statusCode == 200) {
        logger.i('토큰 삭제 성공');
      } else {
        logger.e('서버 에러', error: response.data);
        throw Exception('토큰 삭제 실패');
      }
    } catch (e) {
      logger.e('토큰 삭제 실패', error: e);
      rethrow;
    }
  }
}
