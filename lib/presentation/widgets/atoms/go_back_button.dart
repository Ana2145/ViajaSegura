import 'package:flutter/material.dart';

class GoBackButton extends StatefulWidget {
  final Color? color;
  const GoBackButton({super.key, this.color});

  @override
  State<GoBackButton> createState() => _GoBackButtonState();
}

class _GoBackButtonState extends State<GoBackButton> {
  @override
  Widget build(BuildContext context) {
    final Color buttonColor = widget.color ?? Theme.of(context).primaryColor;

    return IconButton(
      onPressed: _goBack,
      icon: Icon(Icons.chevron_left, color: buttonColor),
    );
  }

  _goBack() => Navigator.of(context).pop();
}
