import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/organisms/notification_card.dart';
import 'package:viaja_segura_movil/presentation/widgets/templates/profile_template.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ProfileTemplate(
      title: 'Notificaciones',
      child: Expanded(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            border: Border.all(color: theme.primaryColor, width: 2.0),
          ),
          child: const SingleChildScrollView(
            child: Column(
              children: [
                NotificationCard(
                  leading: Icon(Icons.warning_amber_outlined),
                  title: '¡Nueva actualización disponible!',
                  subtitle:
                      'Actualiza la aplicación para disfrutar de las nuevas funciones.',
                ),
                NotificationCard(
                  leading: Icon(Icons.warning_amber_outlined),
                  title: '¡Nueva actualización disponible!',
                  subtitle:
                      'Actualiza la aplicación para disfrutar de las nuevas funciones.',
                ),
                NotificationCard(
                  leading: Icon(Icons.warning_amber_outlined),
                  title: '¡Nueva actualización disponible!',
                  subtitle:
                      'Actualiza la aplicación para disfrutar de las nuevas funciones.',
                ),
                NotificationCard(
                  leading: Icon(Icons.warning_amber_outlined),
                  title: '¡Nueva actualización disponible!',
                  subtitle:
                      'Actualiza la aplicación para disfrutar de las nuevas funciones.',
                ),
                NotificationCard(
                  leading: Icon(Icons.warning_amber_outlined),
                  title: '¡Nueva actualización disponible!',
                  subtitle:
                      'Actualiza la aplicación para disfrutar de las nuevas funciones.',
                ),
                NotificationCard(
                  leading: Icon(Icons.warning_amber_outlined),
                  title: '¡Nueva actualización disponible!',
                  subtitle:
                      'Actualiza la aplicación para disfrutar de las nuevas funciones.',
                ),
                NotificationCard(
                  leading: Icon(Icons.warning_amber_outlined),
                  title: '¡Nueva actualización disponible!',
                  subtitle:
                      'Actualiza la aplicación para disfrutar de las nuevas funciones.',
                ),
                NotificationCard(
                  leading: Icon(Icons.warning_amber_outlined),
                  title: '¡Nueva actualización disponible!',
                  subtitle:
                      'Actualiza la aplicación para disfrutar de las nuevas funciones.',
                ),
                NotificationCard(
                  leading: Icon(Icons.warning_amber_outlined),
                  title: '¡Nueva actualización disponible!',
                  subtitle:
                      'Actualiza la aplicación para disfrutar de las nuevas funciones.',
                ),
                NotificationCard(
                  leading: Icon(Icons.warning_amber_outlined),
                  title: '¡Nueva actualización disponible!',
                  subtitle:
                      'Actualiza la aplicación para disfrutar de las nuevas funciones.',
                ),
                NotificationCard(
                  leading: Icon(Icons.warning_amber_outlined),
                  title: '¡Nueva actualización disponible!',
                  subtitle:
                      'Actualiza la aplicación para disfrutar de las nuevas funciones.',
                ),
                NotificationCard(
                  leading: Icon(Icons.warning_amber_outlined),
                  title: '¡Nueva actualización disponible!',
                  subtitle:
                      'Actualiza la aplicación para disfrutar de las nuevas funciones.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
