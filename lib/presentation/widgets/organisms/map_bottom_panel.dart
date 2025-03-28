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
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: theme.canvasColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
        ),
        child: child,
      ),
    );
  }
}
