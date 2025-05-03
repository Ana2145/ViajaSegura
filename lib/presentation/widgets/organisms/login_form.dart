import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viaja_segura_movil/data/cubits/auth/auth_cubit.dart';
import 'package:viaja_segura_movil/data/cubits/auth/auth_state.dart';
import 'package:viaja_segura_movil/data/models/auth_model.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/custom_button.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/custom_snack_bar.dart';
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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is AuthAuthenticated) {
          final driverId = state.authResponse.id;
          final token = state.authResponse.token;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt('driverId', driverId);
          await prefs.setString('token', token);
          Navigator.pushNamed(context, "/");
        } else if (state is AuthError) {
          CustomSnackBar.show(
            context,
            message: state.message,
            snackBarType: SnackBarType.error,
          );
        }
      },
      builder: (context, state) {
        return _buildForm();
      },
    );
  }

  Widget _buildForm() {
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
                onPressed: () {
                  Navigator.pushNamed(context, '/recover_password');
                },
                child: Text(
                  '¿Olvidaste tu contraseña?',
                  style: theme.textTheme.bodySmall,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/create_account');
                },
                child: Text(
                  '¿No tienes una cuenta?',
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
          const SizedBox(height: 24)
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
      final auth = AuthModel(
        email: _emailController.text,
        password: _passwordController.text,
      );

      context.read<AuthCubit>().login(auth);
    }
  }
}
