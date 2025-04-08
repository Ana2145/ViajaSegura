import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final Widget leading;
  final String title;
  final String subtitle;

  const NotificationCard({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.secondary,
          child: leading,
        ),
        title: Text(title, style: theme.textTheme.bodySmall),
        subtitle: Text(subtitle, style: theme.textTheme.bodySmall),
      ),
    );
  }
}
