part of 'rides_cubit.dart';

abstract class RidesState {}

class RidesInitial extends RidesState {}

class RidesLoading extends RidesState {}

class RidesLoaded extends RidesState {
  final List<RideModel> rides;
  RidesLoaded(this.rides);
}

class RidesError extends RidesState {
  final String message;
  RidesError(this.message);
}
