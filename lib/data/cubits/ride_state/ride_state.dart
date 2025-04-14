import 'package:equatable/equatable.dart';
import 'package:viaja_segura_movil/data/models/ride_model.dart';

abstract class RideState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RideInitial extends RideState {}

class RideLoading extends RideState {}

class RideError extends RideState {
  final String message;

  RideError(this.message);

  @override
  List<Object?> get props => [message];
}

class RideLoaded extends RideState {
  final List<RideModel> rides;

  RideLoaded(this.rides);

  @override
  List<Object?> get props => [rides];
}

class RidePending extends RideState {
  final String message;

  RidePending(this.message);

  @override
  List<Object?> get props => [message];
}

class RideInProgress extends RideState {
  final String message;

  RideInProgress(this.message);

  @override
  List<Object?> get props => [message];
}

class RideCancelled extends RideState {
  final String message;

  RideCancelled(this.message);

  @override
  List<Object?> get props => [message];
}

class RideCompleted extends RideState {
  final String message;

  RideCompleted(this.message);

  @override
  List<Object?> get props => [message];
}
