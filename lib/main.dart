import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viaja_segura_movil/core/constants/app_colors.dart';
import 'package:viaja_segura_movil/presentation/screens/splash_screen.dart';
import 'package:viaja_segura_movil/presentation/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Viaja Segura',
      theme: ThemeData(
        textTheme: GoogleFonts.manropeTextTheme(),
        primaryColor: AppColors.primaryColor,
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonColor,
            foregroundColor: AppColors.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            elevation: 0,
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.backgroundColor,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/welcome_screen': (context) => const WelcomeScreen(),
      },
    );
  }
}
