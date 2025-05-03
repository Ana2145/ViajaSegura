import 'package:equatable/equatable.dart';

abstract class DriverAvailabilityState extends Equatable {
  const DriverAvailabilityState();

  @override
  List<Object> get props => [];
}

class DriverAvailabilityInitial extends DriverAvailabilityState {}

class DriverAvailabilityLoading extends DriverAvailabilityState {}

class DriverAvailable extends DriverAvailabilityState {}

class DriverUnavailable extends DriverAvailabilityState {}

class DriverAvailabilityError extends DriverAvailabilityState {
  final String message;
  const DriverAvailabilityError(this.message);

  @override
  List<Object> get props => [message];
}
