import 'package:flutter/material.dart';

class MapBottomPanel extends StatelessWidget {
  final Widget child;

  const MapBottomPanel({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16.0),
      decoration: BoxDecoration(
        color: theme.canvasColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      child: child,
    );
  }
}
