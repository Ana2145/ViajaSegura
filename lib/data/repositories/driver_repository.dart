import 'package:dio/dio.dart';
import 'package:viaja_segura_movil/core/configs/dio_client.dart';
import 'package:viaja_segura_movil/data/models/driver_model.dart';

class DriverRepository {
  final Dio dio = DioClient.instance;

  Future<DriverModel> fetchDriverById(int id) async {
    try {
      final response = await dio.get('/users/drivers/$id');

      try {
        final driver = DriverModel.fromJson(response.data);
        return driver;
      } catch (e) {
        throw Exception('Error al convertir el JSON del conductor');
      }
    } on DioException catch (e) {
      throw Exception('Error al obtener el conductor: ${e.message}');
    }
  }

  Future<void> updateDriverInfo(
      int id, Map<String, dynamic> updatedData) async {
    try {
      final response =
          await dio.put('/users/drivers/$id/info', data: updatedData);
    } on DioException catch (e) {
      throw Exception(
          'Error al actualizar la información del conductor: ${e.message}');
    }
  }
}
