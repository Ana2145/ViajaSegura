import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/organisms/create_account_form.dart';
import 'package:viaja_segura_movil/presentation/widgets/templates/auth_template.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthTemplate(
        title: 'Registrarse', height: 48.0, child: CreateAccountForm());
  }
}
