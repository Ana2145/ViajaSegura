import 'package:dio/dio.dart';
import 'package:viaja_segura_movil/core/configs/dio_client.dart';

class PasswordRepository {
  final Dio dio = DioClient.instance;

  Future<void> requestResetCode(String email) async {
    try {
      final response = await dio.post(
        '/password/request',
        data: {'email': email},
      );
    } on DioException catch (e) {
      throw Exception('Error al enviar el codigo: ${e.message}');
    }
  }

  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    try {
      final response = await dio.post(
        '/password/reset',
        data: {
          'email': email,
          'code': code,
          'newPassword': newPassword,
        },
      );
    } on DioException catch (e) {
      throw Exception('Error al restablecer la contraseña: ${e.message}');
    }
  }
}
