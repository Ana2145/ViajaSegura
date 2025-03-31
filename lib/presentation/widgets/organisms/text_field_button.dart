import 'package:flutter/material.dart';

class TextFieldButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const TextFieldButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 64,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: theme.primaryColor),
          borderRadius: BorderRadius.circular(16),
          color: theme.canvasColor,
        ),
        child: Row(
          children: [
            Icon(icon, color: theme.primaryColor),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
