import 'package:equatable/equatable.dart';

abstract class PasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PasswordInitial extends PasswordState {}

class PasswordLoading extends PasswordState {}

class PasswordSuccess extends PasswordState {
  final String message;

  PasswordSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class PasswordError extends PasswordState {
  final String error;

  PasswordError(this.error);

  @override
  List<Object?> get props => [error];
}
