import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viaja_segura_movil/data/models/ride_model.dart';
import 'package:viaja_segura_movil/data/repositories/ride_repository.dart';

part 'rides_state.dart';

class RidesCubit extends Cubit<RidesState> {
  final RideRepository rideRepository;

  RidesCubit(this.rideRepository) : super(RidesInitial());

  Future<void> fetchRides() async {
    try {
      emit(RidesLoading());
      final rides = await rideRepository.getAllRides();
      emit(RidesLoaded(rides));
    } catch (e) {
      emit(RidesError(
          'Ocurrió un error al obtener los viajes: ${e.toString()}'));
    }
  }
}
