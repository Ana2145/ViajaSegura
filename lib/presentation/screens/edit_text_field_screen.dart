import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/custom_button.dart';
import 'package:viaja_segura_movil/presentation/widgets/molecules/custom_text_form_field.dart';
import 'package:viaja_segura_movil/presentation/widgets/templates/profile_template.dart';

class EditTextFieldScreen extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const EditTextFieldScreen({
    super.key,
    required this.label,
    required this.controller,
    required this.keyboardType,
  });

  @override
  State<EditTextFieldScreen> createState() => _EditTextFieldScreenState();
}

class _EditTextFieldScreenState extends State<EditTextFieldScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ProfileTemplate(
      title: '',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Editar ${widget.label.toLowerCase()}',
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Text(
            'Ingresa tu nuevo ${widget.label.toLowerCase()}',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.secondaryHeaderColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 48),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  focusNode: FocusNode()..requestFocus(),
                  label: widget.label,
                  controller: widget.controller,
                  keyboardType: widget.keyboardType,
                ),
                const SizedBox(height: 32),
                CustomButton(
                  text: 'Guardar',
                  onPressed: _onSubmit,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, widget.controller.text);
    }
  }
}
