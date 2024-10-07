import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../logger/logger.dart';

class DioInterceptor extends Interceptor {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isRefreshing = false;
  final List<Function> _requestQueue = [];

  DioInterceptor(this._dio);

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

      if (_isRefreshing) {
        _requestQueue.add(() async {
          err.requestOptions.headers['Authorization'] = 'Bearer ${await _secureStorage.read(key: 'accessToken')}';
          final retryResponse = await _dio.fetch(err.requestOptions);
          handler.resolve(retryResponse);
        });
      } else {
        _isRefreshing = true;
        try {
          final refreshDio = Dio();

          final response = await refreshDio.post(
            '/auth/refresh',
            data: {'refreshToken': refreshToken},
          );

          final newAccessToken = response.data['accessToken'];
          final newRefreshToken = response.data['refreshToken'];

          if (newAccessToken != null && newRefreshToken != null) {
            await _secureStorage.write(key: 'accessToken', value: newAccessToken);
            await _secureStorage.write(key: 'refreshToken', value: newRefreshToken);

            err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

            final retryResponse = await _dio.fetch(err.requestOptions);

            handler.resolve(retryResponse);

            for (var request in _requestQueue) {
              await request();
            }
            _requestQueue.clear();
          } else {
            signOutAtInterceptor();
            logger.e('새로운 토큰 없음');
            handler.next(err);
          }
        } catch (e) {
          signOutAtInterceptor();
          logger.e('토큰 재발급 실패', error: e);
          handler.next(err);
        } finally {
          _isRefreshing = false;
        }
      }
    } else {
      signOutAtInterceptor();
      handler.next(err);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  Future<void> signOutAtInterceptor() async {
    logger.w('토큰 재발급 실패로 인한 로그아웃');

    await _secureStorage.delete(key: 'accessToken');
    await _secureStorage.delete(key: 'refreshToken');

    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
