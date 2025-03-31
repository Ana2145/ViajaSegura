import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viaja_segura_movil/core/constants/app_colors.dart';
import 'package:viaja_segura_movil/presentation/screens/driver_info_screen.dart';
import 'package:viaja_segura_movil/presentation/screens/login_screen.dart';
import 'package:viaja_segura_movil/presentation/screens/main_screen.dart';
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
        fontFamily: GoogleFonts.manrope().fontFamily,
        textTheme: GoogleFonts.manropeTextTheme().copyWith(
          headlineLarge: const TextStyle(
            color: AppColors.contentColor,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
          headlineMedium: const TextStyle(
            color: AppColors.contentColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          headlineSmall: const TextStyle(
            color: AppColors.contentColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          bodyLarge: const TextStyle(
            color: AppColors.contentColor,
            fontSize: 16,
          ),
          bodyMedium: const TextStyle(
            color: AppColors.contentColor,
            fontSize: 14,
          ),
          bodySmall: const TextStyle(
            color: AppColors.contentColor,
            fontSize: 12,
          ),
        ),
        primaryColor: AppColors.primaryColor,
        canvasColor: AppColors.backgroundColor,
        secondaryHeaderColor: AppColors.secondaryColor,
        focusColor: AppColors.contentColor,
        cardColor: AppColors.whiteColor,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primaryColor,
          secondary: AppColors.secondaryColor,
          surface: AppColors.backgroundColor,
          tertiary: AppColors.detailColor,
        ),
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.contentColor,
            foregroundColor: AppColors.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            elevation: 0,
            textStyle: TextStyle(
              fontFamily: GoogleFonts.manrope().fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.contentColor,
            textStyle: TextStyle(
              fontFamily: GoogleFonts.manrope().fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          prefixIconColor: AppColors.contentColor,
          suffixIconColor: AppColors.contentColor,
          hintStyle: TextStyle(color: AppColors.contentColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: AppColors.contentColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: AppColors.secondaryColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: AppColors.errorColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: AppColors.errorColor),
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.secondaryColor,
          selectionColor: AppColors.secondaryColor,
          selectionHandleColor: AppColors.secondaryColor,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: WidgetStateProperty.all(AppColors.contentColor),
            iconSize: WidgetStateProperty.all(32),
          ),
        ),
        listTileTheme: const ListTileThemeData(
          textColor: AppColors.contentColor,
          iconColor: AppColors.contentColor,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/welcome_screen': (context) => const WelcomeScreen(),
        '/login_screen': (context) => const LoginScreen(),
        '/main_screen': (context) => const MainScreen(),
        '/driver_info_screen': (context) => const DriverInfoScreen(),
      },
    );
  }
}
