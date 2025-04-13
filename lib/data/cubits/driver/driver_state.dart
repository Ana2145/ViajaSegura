import 'package:equatable/equatable.dart';
import 'package:viaja_segura_movil/data/models/driver_model.dart';

abstract class DriverState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DriverInitial extends DriverState {}

class DriverLoading extends DriverState {}

class DriverLoaded extends DriverState {
  final DriverModel driver;

  DriverLoaded(this.driver);

  @override
  List<Object?> get props => [driver];
}

class DriverError extends DriverState {
  final String message;

  DriverError(this.message);

  @override
  List<Object?> get props => [message];
}
