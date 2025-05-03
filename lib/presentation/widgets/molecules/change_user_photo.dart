import 'package:flutter/material.dart';

class ChangeUserPhoto extends StatelessWidget {
  final String name;
  final String lastName;

  const ChangeUserPhoto({
    super.key,
    required this.name,
    required this.lastName,
  });

  String getInitials() {
    final firstInitial = name.isNotEmpty ? name[0] : '';
    final lastInitial = lastName.isNotEmpty ? lastName[0] : '';
    return '$firstInitial$lastInitial'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            theme.primaryColor.withOpacity(0.9),
            theme.primaryColor.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: theme.colorScheme.tertiary,
          width: 4,
        ),
      ),
      child: Center(
        child: Text(
          getInitials(),
          style: theme.textTheme.headlineLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 48,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
