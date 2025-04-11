import 'package:dio/dio.dart';

class DioClient {
  static Dio? _dio;

  static Dio get instance {
    _dio ??= Dio(BaseOptions(
      baseUrl: 'http://192.168.0.175:8080/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));

    return _dio!;
  }
}