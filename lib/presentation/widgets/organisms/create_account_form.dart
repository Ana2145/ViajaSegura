import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/custom_button.dart';
import 'package:viaja_segura_movil/presentation/widgets/molecules/custom_text_form_field.dart';
import 'package:viaja_segura_movil/presentation/widgets/molecules/custom_text_form_field_password.dart';

class CreateAccountForm extends StatefulWidget {
  const CreateAccountForm({super.key});

  @override
  State<CreateAccountForm> createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _usernameController,
            validator: _requiredValidator,
            label: 'Usuario',
            keyboardType: TextInputType.name,
          ),
          const SizedBox(
            height: 24.0,
          ),
          CustomTextFormField(
            controller: _emailController,
            validator: _emailValidator,
            label: 'Correo electrónico',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 24.0,
          ),
          CustomTextFormFieldPassword(
              controller: _passwordController, label: 'Contraseña'),
          const SizedBox(
            height: 32.0,
          ),
          CustomButton(text: 'Continuar', onPressed: _onSubmit),
        ],
      ),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es requerido';
    }
    return null;
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
      // final username = _usernameController.text;
      // final email = _emailController.text;
      // final password = _passwordController.text;

      Navigator.pushNamedAndRemoveUntil(
        context,
        '/main_screen',
        (route) => false,
      );
    }
  }
}
