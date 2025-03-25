import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/templates/splash_template.dart';
import '../widgets/atoms/logo.dart';
import '../widgets/atoms/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashTemplate(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Logo(),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64.0),
            child: Column(
              children: [
                CustomButton(
                    text: 'Registrarse', onPressed: () => print('Registrarse')),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => print('Crear una cuenta'),
                  child: const Text(
                    'Crear una cuenta',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
