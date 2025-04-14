import 'package:flutter/material.dart';

class SearchingForDriver extends StatelessWidget {
  final String message;

  const SearchingForDriver({super.key, this.message = 'Buscando conductor...'});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Positioned(
      top: 96,
      right: 16,
      left: 16,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 32),
              Text(message, style: theme.textTheme.headlineSmall),
            ],
          ),
        ),
      ),
    );
  }
}
