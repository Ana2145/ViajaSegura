import 'package:flutter/material.dart';

class InfoInput extends StatelessWidget {
  final String label;
  final String value;
  const InfoInput({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            readOnly: true,
            initialValue: value,
            decoration: InputDecoration(
                filled: true,
                fillColor: theme.canvasColor,
                border: theme.inputDecorationTheme.enabledBorder,
                focusedBorder: theme.inputDecorationTheme.focusedBorder,
                errorBorder: theme.inputDecorationTheme.errorBorder,
                focusedErrorBorder:
                    theme.inputDecorationTheme.focusedErrorBorder),
          ),
        ],
      ),
    );
  }
}
