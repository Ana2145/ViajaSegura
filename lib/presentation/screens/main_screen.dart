import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/molecules/top_bar.dart';
import '../widgets/organisms/travel_inputs_section.dart';
import '../widgets/atoms/location_button.dart';
import 'driver_list_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _showDriverList = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        _showDriverList = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            'assets/images/map_background.png',
            fit: BoxFit.cover,
          )),
          const Column(
            children: [
              TopBar(),
              SizedBox(height: 20),
              TravelInputsSection(),
            ],
          ),
          const Positioned(
            bottom: 20,
            right: 20,
            child: LocationButton(),
          ),
          if (_showDriverList)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: DriverListScreen(
                onClose: () => setState(() => _showDriverList = false),
              ),
            ),
        ],
      ),
    );
  }
}
