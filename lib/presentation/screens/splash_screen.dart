import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/logo.dart';
import 'package:viaja_segura_movil/presentation/widgets/templates/splash_template.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      if (mounted) {
        Navigator.pushNamed(context, '/welcome_screen');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashTemplate(
      child: Logo(),
    );
  }
}
