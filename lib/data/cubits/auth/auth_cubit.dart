import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viaja_segura_movil/data/cubits/auth/auth_state.dart';
import 'package:viaja_segura_movil/data/models/auth_model.dart';
import 'package:viaja_segura_movil/data/repositories/auth_repository.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit({required this.authRepository}) : super(AuthInitial());

  Future<void> login(AuthModel auth) async {
    emit(AuthLoading());

    try {
      final response = await authRepository.login(auth);

      if (response.error) {
        emit(AuthError(response.message));
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.token);
        await prefs.setString('role', response.role);
        await prefs.setInt('id', response.id);

        emit(AuthAuthenticated(auth));
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
