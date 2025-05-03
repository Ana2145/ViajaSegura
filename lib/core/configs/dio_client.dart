import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  static Dio? _dio;
  static String? _token;

  static Dio get instance {
    if (_dio == null) {
      _dio = Dio(BaseOptions(
        baseUrl: 'http://192.168.1.72:8080/api',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ));

      _dio!.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            _token = await _loadToken();
            if (_token != null) {
              options.headers['Authorization'] = 'Bearer $_token';
            }
            return handler.next(options);
          },
        ),
      );
    }

    return _dio!;
  }

  static Future<String?> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token;
  }

  static Future<void> clearToken() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
