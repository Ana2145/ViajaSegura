import 'package:flutter/material.dart';

class TravelInput extends StatelessWidget {
  final String label;
  final Color iconColor;

  const TravelInput({super.key, required this.label, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Fondo blanco para el input
          borderRadius: BorderRadius.circular(10), // Bordes redondeados
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Sombra
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextFormField(
          style: const TextStyle(fontSize: 14), // Tamaño del texto
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.circle, size: 8, color: iconColor),
            suffixIcon: IconButton(
              onPressed: () => print('Limpiar $label'),
              icon: const Icon(Icons.close, size: 15),
              color: const Color(0xFFAA5F5A),
            ),
            hintText: label,
            hintStyle: const TextStyle(fontSize: 14, color: Color(0xFFAA5F5A)),
            border: InputBorder.none, // Sin bordes
            contentPadding: const EdgeInsets.symmetric(
                vertical: 15, horizontal: 12), // Espaciado
          ),
        ),
      ),
    );
  }
}
