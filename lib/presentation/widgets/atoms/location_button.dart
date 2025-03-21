import 'package:flutter/material.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => print('Centrar ubicación'),
      child: const Icon(Icons.my_location),
    );
  }
}
