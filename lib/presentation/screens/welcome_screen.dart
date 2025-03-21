import 'package:flutter/material.dart';
import '../widgets/molecules/welcome_logo.dart';
import '../widgets/atoms/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF602343),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/vector_up.png',
            width: double.infinity,
          ),
          WelcomeLogo(),
          Column(
            children: [
              CustomButton(
                  text: 'Registrarse', onPressed: () => print('Registrarse')),
              TextButton(
                onPressed: () => print('Crear una cuenta'),
                child: Text('Crear una cuenta',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
          Image.asset('assets/images/vector_down.png', width: double.infinity),
        ],
      ),
    );
  }
}
