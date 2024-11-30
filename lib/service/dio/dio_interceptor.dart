import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:woohakdong/service/general/general_functions.dart';

import '../logger/logger.dart';

class DioInterceptor extends InterceptorsWrapper {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Dio _dio;

  DioInterceptor(this._dio);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String? accessToken = await _secureStorage.read(key: 'accessToken');

    if (!options.uri.path.contains('/auth/login/social')) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      final String? refreshToken = await _secureStorage.read(key: 'refreshToken');

      if (refreshToken != null) {
        try {
          logger.w("액세스 토큰 만료로 인한 토큰 재발급 시도");

          final baseUrl = dotenv.env['V1_SERVER_BASE_URL'];

          // Dio로 시도했을 때, 오류가 계속 발생하여 http로 시도
          final tokenResponse = await http
              .post(
                Uri.parse('$baseUrl/auth/refresh'),
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode({'refreshToken': refreshToken}),
              )
              .timeout(
                const Duration(seconds: 10),
                onTimeout: () => throw TimeoutException('토큰 재발급 시도 타임 아웃'),
              );

          if (tokenResponse.statusCode == 200) {
            final newTokenData = jsonDecode(tokenResponse.body);

            final String newAccessToken = newTokenData['accessToken'];
            final String newRefreshToken = newTokenData['refreshToken'];

            await _secureStorage.write(key: 'accessToken', value: newAccessToken);
            await _secureStorage.write(key: 'refreshToken', value: newRefreshToken);

            err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

            logger.i("토큰 재발급 후 재요청");

            final retryRequest = await _dio.fetch(err.requestOptions);

            return handler.resolve(retryRequest);
          }

          logger.w("리프레시 토큰 만료");
          await _signOutByTokenRefreshFailed();
          return handler.reject(err);
        } on TimeoutException catch (e) {
          logger.w("토큰 재발급 시도 타임 아웃", error: e);
          await GeneralFunctions.toastMessage('네트워크 상태를 확인해 주세요');
          return handler.reject(err);
        } catch (e) {
          logger.e("토큰 재발급 실패", error: e);
          await _signOutByTokenRefreshFailed();
          return handler.reject(err);
        }
      } else {
        logger.w('리프레시 토큰 없음');
        await _signOutByTokenRefreshFailed();
        return handler.reject(err);
      }
    } else {
      logger.e('서버 에러 발생', error: '에러 내용: ${err.response?.data}');

      await Sentry.captureException(
        err,
        stackTrace: err.toString(),
      );

      return handler.reject(err);
    }
  }

  Future<void> _signOutByTokenRefreshFailed() async {
    logger.w('토큰 재발급 실패로 인한 로그아웃');

    await _secureStorage.deleteAll();

    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }
}
