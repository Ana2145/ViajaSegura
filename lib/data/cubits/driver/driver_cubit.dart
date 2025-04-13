import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viaja_segura_movil/data/cubits/driver/driver_state.dart';
import 'package:viaja_segura_movil/data/repositories/driver_repository.dart';

class DriverCubit extends Cubit<DriverState> {
  final DriverRepository _repository;

  DriverCubit(this._repository) : super(DriverInitial());

  Future<void> fetchDriverById(int id) async {
    emit(DriverLoading());
    try {
      final driver = await _repository.fetchDriverById(id);
      emit(DriverLoaded(driver));
    } catch (e) {
      emit(DriverError('Error al obtener datos del conductor'));
    }
  }

  Future<void> fetchDriverFromPrefs() async {
    emit(DriverLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getInt('id');

      if (id == null) {
        emit(DriverError('No se encontró el ID del conductor'));
        return;
      }

      final driver = await _repository.fetchDriverById(id);
      emit(DriverLoaded(driver));
    } catch (e) {
      emit(DriverError('Error al obtener datos del conductor'));
    }
  }

  Future<void> updatedDriver(
      {required int id, required Map<String, dynamic> updatedData}) async {
    try {
      emit(DriverLoading());
      await _repository.updateDriverInfo(id, updatedData);
      final updatedDriver = await _repository.fetchDriverById(id);
      emit(DriverLoaded(updatedDriver));
    } catch (e) {
      emit(DriverError('Error al actualizar la información del conductor'));
    }
  }
}
