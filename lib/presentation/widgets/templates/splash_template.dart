import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/molecules/pattern_row.dart';

class SplashTemplate extends StatelessWidget {
  final Widget child;

  const SplashTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const PatternRow(),
            const SizedBox(height: 64),
            Expanded(child: child),
            const SizedBox(height: 64),
            const PatternRow(isReversed: true),
          ],
        ),
      ),
    );
  }
}
