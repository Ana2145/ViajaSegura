import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final int passengers;

  const IconText({super.key, required this.passengers});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Badge(
        label: Text('$passengers'),
        padding: const EdgeInsets.all(8),
        backgroundColor: Colors.transparent,
        textColor: theme.secondaryHeaderColor,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        child: Icon(Icons.person_outline, color: theme.secondaryHeaderColor),
      ),
    );
  }
}
