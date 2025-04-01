import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String label;
  final bool readOnly;
  final Widget suffix;
  final FocusNode? focusNode;
  final FormFieldValidator<String> validator;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.label,
    this.readOnly = false,
    this.suffix = const SizedBox.shrink(),
    this.focusNode,
    this.validator = _defaultValidator,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

String? _defaultValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Este campo es obligatorio';
  }
  return null;
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          readOnly: widget.readOnly,
          decoration: InputDecoration(suffixIcon: widget.suffix),
          focusNode: widget.focusNode,
          validator: widget.validator,
        ),
      ],
    );
  }
}
