import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  static Dio? _dio;

  static Dio get instance {
    if (_dio == null) {
      _dio = Dio(BaseOptions(
        baseUrl: 'http://192.168.0.175:8080/api',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ));

      _dio!.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            final prefs = await SharedPreferences.getInstance();
            final token = prefs.getString('token');

            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }

            return handler.next(options);
          },
        ),
      );
    }

    return _dio!;
  }
}
