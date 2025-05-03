import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viaja_segura_movil/data/cubits/driver/driver_availability.state.dart';
import 'package:viaja_segura_movil/data/repositories/driver_repository.dart';

class DriverAvailabilityCubit extends Cubit<DriverAvailabilityState> {
  final DriverRepository driverRepository;
  final int driverId;

  DriverAvailabilityCubit({
    required this.driverRepository,
    required this.driverId,
  }) : super(DriverAvailabilityInitial());

  Future<void> fetchAvailability() async {
    emit(DriverAvailabilityLoading());
    try {
      final isAvailable = await driverRepository.getAvailability(driverId);
      emit(isAvailable ? DriverAvailable() : DriverUnavailable());
    } catch (e) {
      emit(DriverAvailabilityError(e.toString()));
    }
  }

  Future<void> toggleAvailability() async {
    emit(DriverAvailabilityLoading());
    try {
      final currentAvailability =
          await driverRepository.getAvailability(driverId);
      final newAvailability = !currentAvailability;
      final updatedAvailability =
          await driverRepository.updateAvailability(driverId, newAvailability);
      emit(updatedAvailability ? DriverAvailable() : DriverUnavailable());
    } catch (e) {
      if (e is DioException) {
        emit(DriverAvailabilityError(
          e.response?.data.toString() ?? e.message ?? 'Error desconocido',
        ));
      } else {
        emit(DriverAvailabilityError(e.toString()));
      }
    }
  }
}
