import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'dio_interceptor.dart';

class DioService {
  final Dio dio;

  DioService._internal(this.dio);

  static final DioService _instance = DioService._internal(
    Dio(
      BaseOptions(
        baseUrl: dotenv.env['V1_SERVER_BASE_URL']!,
      ),
    ),
  );

  factory DioService() {
    _instance._addInterceptors();
    return _instance;
  }

  void _addInterceptors() {
    dio.interceptors.clear();
    dio.interceptors.add(DioInterceptor());
  }

  Dio getDio() => dio;
}
