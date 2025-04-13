import 'package:flutter/material.dart';

class EditDriverInfoButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const EditDriverInfoButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: onPressed,
      tooltip: 'Editar $label',
    );
  }
}
