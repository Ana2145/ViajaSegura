import 'package:flutter/material.dart';

class PanicButton extends StatelessWidget {
  const PanicButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("¡Botón de pánico presionado!"),
      child: Container(
        width: 200,
        height: 200,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF773357),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 30,
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: const Center(
          child: Icon(
            Icons.warning_rounded,
            color: Colors.white,
            size: 60,
          ),
        ),
      ),
    );
  }
}
