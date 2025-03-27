import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/templates/splash_template.dart';
import '../widgets/atoms/logo.dart';
import '../widgets/atoms/custom_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                  onPressed: () => _navigateTo('/main_screen'),
                  text: 'Iniciar sesión',
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => _navigateTo('/register_screen'),
                  child: Text(
                    'Crear una cuenta',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.canvasColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _navigateTo(String route) {
    Navigator.of(context).pushNamed(route);
  }
}
