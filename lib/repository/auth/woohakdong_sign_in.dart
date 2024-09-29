import 'package:dio/dio.dart';

import '../../service/dio/dio_service.dart';
import '../../service/logger/logger.dart';

class WoohakdongSignIn {
  final Dio _dio = DioService().dio;

  Future<Map<String, String>?> woohakdongSignIn(String googleAccessToken) async {
    try {
      Map<String, String> body = {
        'accessToken': googleAccessToken,
      };

      final response = await _dio.post(
        '/v1/auth/login/social',
        data: body,
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is Map<String, dynamic>) {
          String accessToken = responseData['accessToken'];
          String refreshToken = responseData['refreshToken'];

          return {
            'accessToken': accessToken,
            'refreshToken': refreshToken,
          };
        } else {
          logger.e('응답 데이터 형식 확인 필요');
          return null;
        }
      } else {
        logger.e('서버 통신 중 오류 발생: ${response.statusCode}\n응답 내용: ${response.data}');
        return null;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e(e, error: '서버 통신 중 오류 발생: ${e.response?.statusCode}\n응답 내용: ${e.response?.data}');
      } else {
        logger.e(e, error: '서버 통신 중 오류 발생');
      }
      return null;
    } catch (e) {
      logger.e(e, error: '서버 통신 중 오류 발생');
      return null;
    }
  }
}
