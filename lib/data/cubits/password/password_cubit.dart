import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viaja_segura_movil/data/cubits/password/password_state.dart';
import 'package:viaja_segura_movil/data/repositories/password_repository.dart';

class PasswordCubit extends Cubit<PasswordState> {
  final PasswordRepository _repository;

  PasswordCubit(this._repository) : super(PasswordInitial());

  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    emit(PasswordLoading());
    try {
      await _repository.resetPassword(
          email: email, code: code, newPassword: newPassword);
      emit(PasswordSuccess('Contraseña actualizada correctamente'));
    } catch (e) {
      emit(PasswordError('Error al actualizar la contraseña: ${e.toString()}'));
    }
  }

  Future<void> requestPasswordResetCode(String email) async {
    emit(PasswordLoading());
    try {
      await _repository.requestResetCode(email);
      emit(PasswordSuccess('Código de restablecimiento enviado a tu correo.'));
    } catch (e) {
      emit(PasswordError('Error al enciar el codigo: ${e.toString()}'));
    }
  }
}
