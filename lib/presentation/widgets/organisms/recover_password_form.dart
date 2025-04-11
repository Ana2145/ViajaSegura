import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/custom_button.dart';
import 'package:viaja_segura_movil/presentation/widgets/molecules/custom_text_form_field.dart';

class RecoverPasswordForm extends StatefulWidget {
  const RecoverPasswordForm({super.key});

  @override
  State<RecoverPasswordForm> createState() => _RecoverPasswordFormState();
}

class _RecoverPasswordFormState extends State<RecoverPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          CustomButton(
            text: 'Continuar',
            onPressed: _onSubmit,
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
      Navigator.pop(context); //solo cerramos
    }
  }
}
