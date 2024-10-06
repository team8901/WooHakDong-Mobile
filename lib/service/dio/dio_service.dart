import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'dio_interceptor.dart';

class DioService {
  static final DioService _dioServices = DioService._internal();

  factory DioService() => _dioServices;

  static late Dio _dio;

  DioService._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: dotenv.env['V1_SERVER_BASE_URL']!,
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 5000),
      sendTimeout: const Duration(milliseconds: 5000),
      headers: {'Content-Type': 'application/json'},
    );

    _dio = Dio(options);
    _dio.interceptors.add(DioInterceptor(_dio));
  }

  Dio get dio => _dio;
}
