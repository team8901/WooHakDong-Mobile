import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../logger/logger.dart';

class DioInterceptor extends Interceptor {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  DioInterceptor(this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await _secureStorage.read(key: 'accessToken');

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    } else {
      options.headers.remove('Authorization');
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshToken = await _secureStorage.read(key: 'refreshToken');

      try {
        final response = await _dio.post(
          'v1/auth/refresh',
          data: {'refreshToken': refreshToken},
          options: Options(
            headers: {'Authorization': 'Bearer $refreshToken'},
          ),
        );

        final newTokens = response.data;

        if (newTokens != null && newTokens['accessToken'] != null && newTokens['refreshToken'] != null) {
          await _secureStorage.write(key: 'accessToken', value: newTokens['accessToken']);
          await _secureStorage.write(key: 'refreshToken', value: newTokens['refreshToken']);

          err.requestOptions.headers['Authorization'] = 'Bearer ${newTokens['accessToken']}';

          final retryResponse = await _dio.fetch(err.requestOptions);

          return handler.resolve(retryResponse);
        } else {
          logger.e('새로운 토큰 없음');
          return handler.next(err);
        }
      } catch (e) {
        logger.e('토큰 재발급 실패', error: e);
        return handler.next(err);
      }
    } else {
      return handler.next(err);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }
}
