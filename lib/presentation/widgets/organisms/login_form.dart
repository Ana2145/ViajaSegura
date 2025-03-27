import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/custom_button.dart';
import 'package:viaja_segura_movil/presentation/widgets/molecules/custom_text_form_field.dart';
import 'package:viaja_segura_movil/presentation/widgets/molecules/custom_text_form_field_password.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            label: 'Correo electrónico',
            validator: _emailValidator,
          ),
          const SizedBox(height: 32.0),
          CustomTextFormFieldPassword(
            controller: _passwordController,
            label: 'Contraseña',
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  '¿Olvidaste tu usuario?',
                  style: theme.textTheme.bodySmall,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: Text(
                  '¿Olvidaste tu contraseña?',
                  style: theme.textTheme.bodySmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32.0),
          CustomButton(
            text: 'Ingresar',
            onPressed: _onSubmit,
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {},
            child: const Text('Crear una cuenta'),
          ),
        ],
      ),
    );
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingresa tu correo electrónico';
    }
    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Correo electrónico inválido';
    }
    return null;
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      //final email = _emailController.text;
      //final password = _passwordController.text;

      Navigator.pushNamed(context, '/home');
    }
  }
}
