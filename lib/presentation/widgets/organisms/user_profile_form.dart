import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/molecules/change_user_photo.dart';
import 'package:viaja_segura_movil/presentation/widgets/molecules/custom_text_form_field.dart';
import 'package:viaja_segura_movil/presentation/widgets/organisms/edit_user_info_button.dart';

class UserProfileForm extends StatefulWidget {
  const UserProfileForm({super.key});

  @override
  State<UserProfileForm> createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {
  final TextEditingController _nameController =
      TextEditingController(text: 'Cristopher');

  final TextEditingController _surnameController =
      TextEditingController(text: 'Soto Ventura');

  final TextEditingController _emailController =
      TextEditingController(text: '20213tn044@utez.edu.mx');

  final TextEditingController _phoneController =
      TextEditingController(text: '987654321');

  final TextEditingController _passwordController =
      TextEditingController(text: '•••••••••');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        const ChangeUserPhoto(),
        const SizedBox(height: 16.0),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.primaryColor),
          ),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              CustomTextFormField(
                label: 'Correo electrónico',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                readOnly: true,
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                label: 'Nombre',
                controller: _nameController,
                keyboardType: TextInputType.text,
                readOnly: true,
                suffix: EditUserInfoButton(
                  label: 'Nombre',
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                label: 'Apellido(s)',
                controller: _surnameController,
                keyboardType: TextInputType.text,
                readOnly: true,
                suffix: EditUserInfoButton(
                  label: 'Apellido(s)',
                  controller: _surnameController,
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                label: 'Número de teléfono',
                controller: _phoneController,
                keyboardType: TextInputType.number,
                readOnly: true,
                suffix: EditUserInfoButton(
                  label: 'Número de teléfono',
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                label: 'Cambiar contraseña',
                controller: _passwordController,
                keyboardType: TextInputType.text,
                readOnly: true,
                suffix: EditUserInfoButton(
                  label: 'Contraseña',
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
