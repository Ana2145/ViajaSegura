import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/templates/profile_template.dart';

class TravelHistoryScreen extends StatelessWidget {
  const TravelHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileTemplate(
        title: 'Mis viajes', child: Text('data'));
  }
}
