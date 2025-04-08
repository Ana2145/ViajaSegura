import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/go_back_button.dart';

class GoBackTitle extends StatelessWidget {
  final String title;

  const GoBackTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        children: [
          const GoBackButton(),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: theme.textTheme.headlineMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(width: 64),
        ],
      ),
    );
  }
}
