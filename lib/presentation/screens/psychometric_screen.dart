import 'package:flutter/material.dart';
import '../widgets/atoms/back_button_atoms.dart';
import '../widgets/organisms/psychometric_content.dart';

class PsychometricScreen extends StatelessWidget {
  const PsychometricScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Vectores de fondo
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/images/vectors.png",
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/images/vectors.png",
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Botón de regreso en la esquina superior izquierda
          Positioned(
            top: 20,
            left: 20,
            child: BackButtonAtoms(
              onTap: () => Navigator.pop(context),
            ),
          ),
          // Contenido principal centrado
          const Center(
            child: PsychometricContent(),
          ),
        ],
      ),
    );
  }
}
