import 'package:flutter/material.dart';
import '../widgets/molecules/top_bar.dart';
import '../widgets/organisms/travel_inputs_section.dart';
import '../widgets/atoms/location_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            'assets/images/map_background.png',
            fit: BoxFit.cover,
          )),
          Column(
            children: [
              const TopBar(),
              const SizedBox(height: 20),
              const TravelInputsSection(),
            ],
          ),
          const Positioned(
            bottom: 20,
            right: 20,
            child: LocationButton(),
          ),
        ],
      ),
    );
  }
}
