import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/molecules/drawer_list_card.dart';
import 'package:viaja_segura_movil/presentation/widgets/templates/drawer_bottom_card_template.dart';
import 'package:viaja_segura_movil/presentation/widgets/templates/profile_template.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {'title': '¡Nueva actualización disponible!'},
      {'title': '¡Nueva actualización disponible!'},
      {'title': '¡Nueva actualización disponible!'},
    ];

    return ProfileTemplate(
      title: 'Notificaciones',
      child: DrawerBottomCardTemplate(
        children: List.generate(
          notifications.length,
          (index) => DrawerListCard(title: notifications[index]['title']!),
        ),
      ),
    );
  }
}
