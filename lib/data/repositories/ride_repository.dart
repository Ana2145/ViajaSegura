import 'package:dio/dio.dart';
import 'package:viaja_segura_movil/core/configs/dio_client.dart';
import 'package:viaja_segura_movil/data/models/ride_model.dart';

class RideRepository {
  final Dio dio = DioClient.instance;

  Future<List<RideModel>> getAllRides() async {
    //ya no me sirve, es generico
    final response = await dio.get('/rides/get-all');
    final data = response.data as List;
    return data.map((json) => RideModel.fromJson(json)).toList();
  }

  Future<List<RideModel>> getRidesByDriverId(int driverId) async {
    final response = await dio.get('/rides/driver/$driverId');
    final data = response.data as List;
    return data.map((json) => RideModel.fromJson(json)).toList();
  }
}
