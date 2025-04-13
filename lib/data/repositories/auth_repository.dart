import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:viaja_segura_movil/core/configs/dio_client.dart';
import 'package:viaja_segura_movil/data/models/auth_model.dart';
import 'package:viaja_segura_movil/data/repositories/auth_response.dart';

class AuthRepository {
  final Dio dio = DioClient.instance;

  Future<AuthResponse> login(AuthModel auth) async {
    try {
      final response =
          await dio.post('/auth/login', data: jsonEncode(auth.toJson()));

      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return AuthResponse(
          token: '',
          role: '',
          id: 0,
          error: true,
          statusCode: 401,
          message: 'Correo electrónico o contraseña incorrectos',
        );
      } else {
        return AuthResponse(
          token: '',
          role: '',
          id: 0,
          error: true,
          statusCode: e.response?.statusCode ?? 500,
          message: e.response?.data['message'] ?? 'Error de conexión',
        );
      }
    }
  }
}
