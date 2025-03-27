import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/organisms/login_form.dart';
import 'package:viaja_segura_movil/presentation/widgets/templates/auth_template.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthTemplate(
      title: 'Iniciar Sesión',
      form: LoginForm(),
    );
  }
}
