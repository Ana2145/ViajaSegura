import 'package:dio/dio.dart';
import 'package:viaja_segura_movil/core/configs/dio_client.dart';
import 'package:viaja_segura_movil/data/models/ride_model.dart';

class RideRepository {
  final Dio dio = DioClient.instance;

  Future<List<RideModel>> getRidesByPassengerId(int id) async {
    try {
      final response = await dio.get('/rides/passenger/$id');
      if (response.statusCode == 200) {
        List<RideModel> rides = (response.data as List)
            .map((ride) => RideModel.fromJson(ride))
            .toList();
        return rides;
      } else {
        throw Exception('Failed to load rides');
      }
    } on DioException catch (e) {
      throw Exception('Error fetching rides: ${e.message}');
    }
  }

  Future<RideModel> createRide(RideModel ride) async {
    try {
      final response = await dio.post('/rides/create', data: ride.toJson());
      return RideModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Error creating ride: ${e.message}');
    }
  }
}
