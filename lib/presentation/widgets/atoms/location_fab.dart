import 'package:flutter/material.dart';

class LocationFab extends StatelessWidget {
  final Function onPressed;

  const LocationFab({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () => onPressed(),
      backgroundColor: Theme.of(context).canvasColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(64)),
      child: Icon(Icons.my_location, color: Theme.of(context).primaryColor),
    );
  }
}
