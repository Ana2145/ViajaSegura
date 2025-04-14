import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/custom_button.dart';

class LocationError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const LocationError({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              color: theme.secondaryHeaderColor,
              Icons.location_off,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            CustomButton(text: 'Reintentar', onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}
