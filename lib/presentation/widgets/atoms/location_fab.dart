import 'package:flutter/material.dart';

class LocationFab extends StatelessWidget {
  final Function onPressed;

  const LocationFab({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () => onPressed(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(64)),
      child: const Icon(Icons.my_location),
    );
  }
}
