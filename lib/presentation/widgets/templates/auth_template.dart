import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/molecules/pattern_row.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/go_back_button.dart';

class AuthTemplate extends StatefulWidget {
  final String title;
  final double height;
  final Widget child;

  const AuthTemplate({
    super.key,
    required this.title,
    this.height = 64.0,
    required this.child,
  });

  @override
  State<AuthTemplate> createState() => _AuthTemplateState();
}

class _AuthTemplateState extends State<AuthTemplate> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color primaryColor = theme.primaryColor;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            PatternRow(height: 10, color: primaryColor),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const GoBackButton(),
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          children: [
                            Text(
                              widget.title,
                              style: theme.textTheme.headlineLarge,
                            ),
                            SizedBox(height: widget.height),
                            widget.child,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            PatternRow(height: 10, color: primaryColor, isReversed: true),
          ],
        ),
      ),
    );
  }
}
