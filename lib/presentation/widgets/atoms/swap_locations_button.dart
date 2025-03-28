import 'package:flutter/material.dart';

class SwapLocationsButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SwapLocationsButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.swap_vert),
      onPressed: onPressed,
    );
  }
}
