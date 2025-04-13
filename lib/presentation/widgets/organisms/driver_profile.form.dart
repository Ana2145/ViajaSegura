import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:viaja_segura_movil/data/cubits/driver/driver_cubit.dart';
import 'package:viaja_segura_movil/data/cubits/driver/driver_state.dart';
import 'package:viaja_segura_movil/data/models/driver_model.dart';

import 'package:viaja_segura_movil/presentation/widgets/molecules/change_user_photo.dart';
import 'package:viaja_segura_movil/presentation/widgets/molecules/custom_text_form_field.dart';
import 'package:viaja_segura_movil/presentation/widgets/organisms/edit_user_info_button.dart';

class DriverProfileForm extends StatefulWidget {
  const DriverProfileForm({super.key});

  @override
  State<DriverProfileForm> createState() => _DriverProfileFormState();
}

class _DriverProfileFormState extends State<DriverProfileForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController(text: '•••••••••');

  DriverModel? _driver;

  @override
  void initState() {
    super.initState();
    _loadDriverInfo();
  }

  Future<void> _loadDriverInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('id');
    if (id != null) {
      final cubit = context.read<DriverCubit>();
      await cubit.fetchDriverById(id);

      final state = cubit.state;
      if (state is DriverLoaded) {
        setState(() {
          _driver = state.driver;
          _nameController.text = _driver!.name;
          _surnameController.text = _driver!.lastname;
          _emailController.text = _driver!.email;
          _phoneController.text = _driver!.phoneNumber;
        });
      }
    }
  }

  Future<void> _saveDriverInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('id');

    if (id == null) {
      return;
    }

    final updatedData = {
      'name': _nameController.text,
      'lastName': _surnameController.text,
      'phone': _phoneController.text,
    };

    context.read<DriverCubit>().updatedDriver(id: id, updatedData: updatedData);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<DriverCubit, DriverState>(
      listener: (context, state) {
        if (state is DriverLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Información actualizada exitosamente')),
          );
        } else if (state is DriverError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      child: Column(
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
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _saveDriverInfo,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Guardar cambios'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
