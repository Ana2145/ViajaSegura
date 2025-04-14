import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/screens/edit_text_field_screen.dart';

class EditUserInfoButton extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const EditUserInfoButton({
    super.key,
    required this.label,
    required this.controller,
    required this.keyboardType,
  });

  @override
  State<EditUserInfoButton> createState() => _EditUserInfoButtonState();
}

class _EditUserInfoButtonState extends State<EditUserInfoButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: IconButton(
        icon: const Icon(Icons.edit_outlined),
        onPressed: () => _editUserInfo(context),
      ),
    );
  }

  Future<void> _editUserInfo(BuildContext context) async {
    final editedValue = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTextFieldScreen(
          label: widget.label,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
        ),
      ),
    );

    if (editedValue != null && editedValue is String) {
      setState(() => widget.controller.text = editedValue);
    }
  }
}
