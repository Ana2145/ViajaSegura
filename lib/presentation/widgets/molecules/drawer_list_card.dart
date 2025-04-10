import 'package:flutter/material.dart';

class DrawerListCard extends StatelessWidget {
  final String title;
  final bool hasAction;
  final VoidCallback onTap;

  const DrawerListCard({
    super.key,
    required this.title,
    this.hasAction = false,
    this.onTap = _defaultOnTap,
  });

  static void _defaultOnTap() {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColor = theme.colorScheme.secondary;
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 0,
        child: ListTile(
          iconColor: themeColor,
          minLeadingWidth: 0,
          leading: const Icon(Icons.circle, size: 12),
          title: Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: themeColor,
            ),
          ),
          trailing:
              hasAction ? Icon(Icons.chevron_right, color: themeColor) : null,
        ),
      ),
    );
  }
}
