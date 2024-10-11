import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../logger/logger.dart';

class DioInterceptor extends InterceptorsWrapper {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Dio _dio;

  DioInterceptor(this._dio);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    logger.t("[${options.method}] [${options.uri}]");

    if (options.path != '/auth/refresh') {
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
      final String? refreshToken = await _secureStorage.read(key: 'refreshToken');

      if (refreshToken != null) {
        try {
          logger.w("토큰 만료로 인한 토큰 재발급 시도");

          // Dio로 시도했을 떄, 오류가 계속 발생하여 http로 시도
          final tokenResponse = await http.post(
            Uri.parse('${dotenv.env['V1_SERVER_BASE_URL']}/auth/refresh'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'refreshToken': refreshToken}),
          );

          if (tokenResponse.statusCode == 200) {
            logger.i("토큰 재발급 성공, 요청 재시도");

            final newTokenData = jsonDecode(tokenResponse.body);

            final String newAccessToken = newTokenData['accessToken'];
            final String newRefreshToken = newTokenData['refreshToken'];

            await _secureStorage.write(key: 'accessToken', value: newAccessToken);
            await _secureStorage.write(key: 'refreshToken', value: newRefreshToken);

            err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

            final retryRequest = await _dio.request(
              options: Options(
                method: err.requestOptions.method,
                headers: err.requestOptions.headers,
              ),
              err.requestOptions.path,
              data: err.requestOptions.data,
              queryParameters: err.requestOptions.queryParameters,
            );

            return handler.resolve(retryRequest);
          }
        } catch (e) {
          logger.e("토큰 재발급 실패", error: e);
          _signOutAtInterceptor();
          return handler.reject(err);
        }
      } else {
        logger.e('리프레시 토큰이 없음');
        _signOutAtInterceptor();
        return handler.reject(err);
      }
    }
  }

  Future<void> _signOutAtInterceptor() async {
    logger.w('엑세스 토큰 만료에 토큰 재발급 실패로 인한 로그아웃');

    await _secureStorage.delete(key: 'accessToken');
    await _secureStorage.delete(key: 'refreshToken');

    await _firebaseAuth.signOut();

    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.signOut();
    }
  }
}
