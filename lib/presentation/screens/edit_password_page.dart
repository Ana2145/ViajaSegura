import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viaja_segura_movil/data/cubits/password/password_cubit.dart';
import 'package:viaja_segura_movil/data/cubits/password/password_state.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/custom_button.dart';
import 'package:viaja_segura_movil/presentation/widgets/molecules/custom_text_form_field.dart';

class EditPasswordPage extends StatefulWidget {
  final String email;

  const EditPasswordPage({Key? key, required this.email}) : super(key: key);

  @override
  _EditPasswordPageState createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await context
          .read<PasswordCubit>()
          .requestPasswordResetCode(widget.email);

      final state = context.read<PasswordCubit>().state;
      if (state is PasswordSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      } else if (state is PasswordError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al solicitar código: ${state.error}')),
        );
      }
    });
  }

  @override
  void dispose() {
    _codeController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Editar Contraseña")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<PasswordCubit, PasswordState>(
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: _codeController,
                    label: 'Código',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El código es requerido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _newPasswordController,
                    label: 'Nueva Contraseña',
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'La contraseña es requerida';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  state is PasswordLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          text: 'Restablecer Contraseña',
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              await context.read<PasswordCubit>().resetPassword(
                                    email: widget.email,
                                    code: _codeController.text,
                                    newPassword: _newPasswordController.text,
                                  );

                              final state = context.read<PasswordCubit>().state;

                              if (state is PasswordSuccess) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.message)),
                                );
                                Navigator.pop(context);
                              } else if (state is PasswordError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.error)),
                                );
                              }
                            }
                          },
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
