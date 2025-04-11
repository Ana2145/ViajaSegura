import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/molecules/drawer_list_card.dart';
import 'package:viaja_segura_movil/presentation/widgets/templates/drawer_bottom_card_template.dart';
import 'package:viaja_segura_movil/presentation/widgets/templates/profile_template.dart';

class TripHistoryScreen extends StatelessWidget {
  const TripHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final trips = [
      {'title': 'Temixco'},
      {'title': 'Teatro Ocampo'},
      {'title': 'Lomas de la Selva'},
    ];
    return ProfileTemplate(
      title: 'Mis viajes',
      child: DrawerBottomCardTemplate(
        children: List.generate(
          trips.length,
          (index) {
            return DrawerListCard(
              title: "Viaje a ${trips[index]['title']!}",
              hasAction: true,
              onTap: () {
                Navigator.pushNamed(context, '/trip_history_details');
              },
            );
          },
        ),
      ),
    );
  }
}
