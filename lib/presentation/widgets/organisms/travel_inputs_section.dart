import 'package:flutter/material.dart';
import '../atoms/travel_input.dart';

class TravelInputsSection extends StatelessWidget {
  const TravelInputsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        TravelInput(
          label: 'Inicio de viaje',
          iconColor: Color(0xFFBC9B73),
        ),
        TravelInput(
          label: 'Fin de viaje',
          iconColor: Color(0xFF773357),
        ),
      ],
    );
  }
}
