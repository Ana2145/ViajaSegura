import 'package:flutter/material.dart';

class MapSearchButton extends StatelessWidget {
  final VoidCallback onPressed;

  const MapSearchButton({
    super.key,
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
        child: const Row(
          children: [
            Icon(Icons.search),
            SizedBox(width: 8),
            Text(
              '¿A dónde quieres ir?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}