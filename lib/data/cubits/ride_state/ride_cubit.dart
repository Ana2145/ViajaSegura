import 'package:bloc/bloc.dart';

import 'package:viaja_segura_movil/data/cubits/ride_state/ride_state.dart';
import 'package:viaja_segura_movil/data/models/ride_model.dart';
import 'package:viaja_segura_movil/data/repositories/ride_repository.dart';

class RideCubit extends Cubit<RideState> {
  final RideRepository rideRepository;

  RideCubit({required this.rideRepository}) : super(RideInitial());

  Future<List<RideModel>> getRidesByPassengerId(int id) async {
    emit(RideLoading());
    try {
      final response = await rideRepository.getRidesByPassengerId(id);
      emit(RideLoaded(response));
      return response;
    } catch (e) {
      emit(RideError('Error inesperado al cargar los viajes'));
      rethrow;
    }
  }

  Future<RideModel> createRide(RideModel ride) async {
    emit(RideLoading());
    try {
      final response = await rideRepository.createRide(ride);
      emit(RidePending(response.status.name));
      return response;
    } catch (e) {
      emit(RideError('Error inesperado al crear el viaje'));
      rethrow;
    }
  }

}
