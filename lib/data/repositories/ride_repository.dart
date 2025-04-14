import 'package:dio/dio.dart';
import 'package:viaja_segura_movil/core/configs/dio_client.dart';
import 'package:viaja_segura_movil/data/models/ride_model.dart';

class RideRepository {
  final Dio dio = DioClient.instance;

  Future<List<RideModel>> getAllRides() async {
    final response = await dio.get('/rides/get-all');
    final data = response.data['data'] as List;
    return data.map((json) => RideModel.fromJson(json)).toList();
  }
}
