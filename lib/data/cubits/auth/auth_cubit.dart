import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viaja_segura_movil/data/cubits/auth/auth_state.dart';
import 'package:viaja_segura_movil/data/models/auth_model.dart';
import 'package:viaja_segura_movil/data/repositories/auth_repository.dart';
import 'package:viaja_segura_movil/data/repositories/auth_response.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit({required this.authRepository}) : super(AuthInitial());

  Future<void> login(AuthModel auth) async {
    emit(AuthLoading());

    try {
      final AuthResponse authResponse = await authRepository.login(auth);

      if (authResponse.error) {
        emit(AuthError(authResponse.message));
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', authResponse.token);
        await prefs.setString('role', authResponse.role);
        await prefs.setInt('id', authResponse.id);

        emit(AuthAuthenticated(authResponse));
      }
    } catch (e, stackTrace) {
      emit(AuthError('Error inesperado al hacer login'));
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    emit(AuthInitial());
  }
}
