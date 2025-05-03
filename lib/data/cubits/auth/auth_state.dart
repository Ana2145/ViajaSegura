import 'package:equatable/equatable.dart';
import 'package:viaja_segura_movil/data/repositories/auth_response.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final AuthResponse authResponse;

  AuthAuthenticated(this.authResponse);

  @override
  List<Object?> get props => [authResponse];
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
