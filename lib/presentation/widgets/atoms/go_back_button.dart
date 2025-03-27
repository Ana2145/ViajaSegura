import 'package:flutter/material.dart';

class GoBackButton extends StatefulWidget {
  const GoBackButton({super.key});

  @override
  State<GoBackButton> createState() => _GoBackButtonState();
}

class _GoBackButtonState extends State<GoBackButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _goBack,
      icon: const Icon(Icons.chevron_left),
    );
  }

  void _goBack() {
    Navigator.of(context).pop();
  }
}
