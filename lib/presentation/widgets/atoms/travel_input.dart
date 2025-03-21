import 'package:flutter/material.dart';

class TravelInput extends StatelessWidget {
  final String label;
  final Color iconColor;
  const TravelInput({super.key, required this.label, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.circle, size: 12, color: iconColor),
          suffixIcon: IconButton(
            onPressed: () => print('Limpiar $label'),
            icon: const Icon(Icons.close),
          ),
          hintText: label,
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xAA773357)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xAA773357)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color.fromARGB(222, 130, 54, 95),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
