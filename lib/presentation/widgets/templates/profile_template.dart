import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/molecules/pattern_row.dart';
import 'package:viaja_segura_movil/presentation/widgets/organisms/go_back_title.dart';

class ProfileTemplate extends StatelessWidget {
  final String title;
  final Widget child;
  final bool isDrawer;

  const ProfileTemplate({
    super.key,
    required this.title,
    required this.child,
    this.isDrawer = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Stack(
          children: [
            PatternRow(
              color: theme.colorScheme.tertiary,
              isTransparent: false,
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(children: [GoBackTitle(title: title), child]),
            ),
          ],
        ),
      ),
    );
  }
}
