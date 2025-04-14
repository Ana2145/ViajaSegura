import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final role = prefs.getString('role');
      final token = prefs.getString('token');

      if (mounted) {
        if (token != null && role != null) {
          Navigator.pushNamed(context, '/home_d');
        } else {
          Navigator.pushNamed(context, '/welcome_screen');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashTemplate(child: Logo());
  }
}
