import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/organisms/recover_password_form.dart';
import 'package:viaja_segura_movil/presentation/widgets/templates/auth_template.dart';

class RecoverPasswordScreen extends StatelessWidget {
  const RecoverPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthTemplate(
      title: 'Recuperar contraseña',
      child: RecoverPasswordForm(),
    );
  }
}
