import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:woohakdong/service/dio/dio_service.dart';
import 'package:woohakdong/service/logger/logger.dart';

import '../../repository/auth/token_manage.dart';

class DioInterceptor extends Interceptor {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final TokenManage _tokenManage = TokenManage();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await _secureStorage.read(key: 'accessToken');

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshToken = await _secureStorage.read(key: 'refreshToken');

      if (refreshToken != null) {
        try {
          final newTokens = await _tokenManage.getBackToken(refreshToken);

          if (newTokens != null) {
            await _secureStorage.write(key: 'accessToken', value: newTokens['accessToken']);
            await _secureStorage.write(key: 'refreshToken', value: newTokens['refreshToken']);

            final requestOptions = err.requestOptions;
            final newAccessToken = newTokens['accessToken'];
            requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

            final dio = DioService().dio;
            final response = await dio.fetch(requestOptions);

            return handler.resolve(response);
          } else {
            logger.e('재발급 토큰 없음');
            await _secureStorage.deleteAll();
          }
        } catch (e) {
          logger.e('토큰 재발급 실패', error: e);
          await _secureStorage.deleteAll();
        }
      } else {
        logger.e('refreshToken 없음');
        await _secureStorage.deleteAll();
      }
    }

    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }
}
