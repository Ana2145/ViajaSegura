import 'package:flutter/material.dart';

class PsychometricButton extends StatelessWidget {
  final VoidCallback onTap;
  const PsychometricButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          backgroundColor: const Color(0xFF773357),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      child: const Text(
        "Examen psicométrico",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
