import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/molecules/pattern_row.dart';

class SplashTemplate extends StatelessWidget {
  final Widget child;

  const SplashTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color canvasColor = theme.canvasColor;
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            PatternRow(color: canvasColor),
            const SizedBox(height: 64),
            Expanded(child: child),
            const SizedBox(height: 64),
            PatternRow(color: canvasColor, isReversed: true),
          ],
        ),
      ),
    );
  }
}
