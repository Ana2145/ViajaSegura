import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/templates/profile_template.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileTemplate(title: 'Notificaciones', child: Text('data'));
  }
}
