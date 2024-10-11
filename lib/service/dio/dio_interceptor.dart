import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../logger/logger.dart';

class DioInterceptor extends InterceptorsWrapper {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    logger.t("${options.uri}로 요청 시도");

    if (options.path != '/auth/refresh' || options.path != '/auth/logout') {
      String? accessToken = await _secureStorage.read(key: 'accessToken');

      if (accessToken != null) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      logger.w("토큰 만료로 인한 토큰 재발급 시도");

      RequestOptions options = err.requestOptions;
      String? refreshToken = await _secureStorage.read(key: 'refreshToken');

      if (refreshToken != null) {
        try {
          final tokenResponse = await Dio().post(
            '/auth/refresh',
            data: {
              'refresh_token': refreshToken,
            },
          );

          if (tokenResponse.statusCode == 200) {
            logger.i("토큰 재발급 성공, 요청 재시도");

            String newAccessToken = tokenResponse.data['accessToken'];
            String newRefreshToken = tokenResponse.data['refreshToken'];

            await _secureStorage.write(key: 'accessToken', value: newAccessToken);
            await _secureStorage.write(key: 'refreshToken', value: newRefreshToken);

            options.headers['Authorization'] = 'Bearer $newAccessToken';

            final response = await Dio().request(
              options.path,
              options: Options(
                headers: options.headers,
                method: options.method,
              ),
              data: options.data,
              queryParameters: options.queryParameters,
            );

            return handler.resolve(response);
          }
        } catch (e) {
          logger.e("토큰 재발급 실패", error: e);
          signOutAtInterceptor();
          return handler.reject(err);
        }
      }
    }

    return handler.reject(err);
  }

  Future<void> signOutAtInterceptor() async {
    logger.w('엑세스 토큰 만료에 토큰 재발급 실패로 인한 로그아웃');

    await _secureStorage.delete(key: 'accessToken');
    await _secureStorage.delete(key: 'refreshToken');

    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }
}
