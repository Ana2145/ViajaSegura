import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/organisms/text_field_button.dart';

class RouteButtonsPanel extends StatelessWidget {
  final String start;
  final String destination;
  final VoidCallback onStartPressed;
  final VoidCallback onDestinationPressed;

  const RouteButtonsPanel({
    super.key,
    required this.start,
    required this.destination,
    required this.onStartPressed,
    required this.onDestinationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 96,
      right: 16,
      left: 16,
      child: Column(
        children: [
          TextFieldButton(
            icon: Icons.location_on,
            text: start,
            onPressed: onStartPressed,
          ),
          const SizedBox(height: 8),
          TextFieldButton(
            icon: Icons.flag,
            text: destination,
            onPressed: onDestinationPressed,
          ),
        ],
      ),
    );
  }
}
