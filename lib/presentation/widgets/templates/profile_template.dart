import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/go_back_button.dart';
import 'package:viaja_segura_movil/presentation/widgets/molecules/pattern_row.dart';

class ProfileTemplate extends StatelessWidget {
  final String title;
  final Widget child;

  const ProfileTemplate({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              PatternRow(color: theme.primaryColor, height: 4),
              Column(
                children: [
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const GoBackButton(),
                            Expanded(
                              child: Center(
                                child: Text(
                                  title,
                                  style: theme.textTheme.headlineLarge,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(width: 64),
                          ],
                        ),
                        const SizedBox(height: 32),
                        child,
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
