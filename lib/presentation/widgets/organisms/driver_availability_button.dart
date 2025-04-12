import 'dart:async';
import 'package:flutter/material.dart';

class DriverAvailabilityButton extends StatefulWidget {
  const DriverAvailabilityButton({super.key});

  @override
  State<DriverAvailabilityButton> createState() =>
      _DriverAvailabilityButtonState();
}

class _DriverAvailabilityButtonState extends State<DriverAvailabilityButton> {
  bool isReady = true;
  int dotCount = 0;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startWaitingAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      setState(() {
        dotCount = (dotCount + 1) % 4;
      });
    });
  }

  void _onPressed() {
    if (isReady) {
      setState(() {
        isReady = false;
        dotCount = 0;
      });
      _startWaitingAnimation();
    }
    //logica para show viajes disponibles
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: _onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        isReady ? 'Listo para viajar' : 'En espera de viajes${'.' * dotCount}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
