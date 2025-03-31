import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/car_image.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/custom_button.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/icon_text.dart';

class DriverInfoBottomSheet extends StatefulWidget {
  final String carName;
  final String plateNumber;
  final int passengers;
  final String color;

  const DriverInfoBottomSheet({
    super.key,
    required this.carName,
    required this.plateNumber,
    required this.passengers,
    required this.color,
  });

  @override
  State<DriverInfoBottomSheet> createState() => _DriverInfoBottomSheetState();
}

class _DriverInfoBottomSheetState extends State<DriverInfoBottomSheet> {
  Widget _buildInfo(String label, String info, ThemeData theme) {
    final textColor = theme.secondaryHeaderColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(info, style: TextStyle(color: textColor)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
      child: Column(
        children: [
          Text(
            "Información del conductor",
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 32.0),
          Card(
            color: Colors.white,
            elevation: 0,
            child: ListTile(
              onTap: _showDriverInfo,
              leading: const CircleAvatar(
                radius: 24,
                child: Icon(Icons.person),
              ),
              title: const Text("Nombre del conductor"),
              subtitle: const Text("Organización"),
              trailing: const Icon(Icons.info_outlined),
            ),
          ),
          const SizedBox(height: 8.0),
          Card(
            color: Colors.white,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarImage(size: 132, color: widget.color),
                  const SizedBox(width: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfo("PLACAS", widget.plateNumber, theme),
                      const SizedBox(height: 16),
                      _buildInfo("VEHÍCULO", widget.carName, theme),
                    ],
                  ),
                  const Spacer(),
                  IconText(passengers: widget.passengers),
                ],
              ),
            ),
          ),
          const Spacer(),
          CustomButton(text: "Solicitar", onPressed: () {}),
        ],
      ),
    );
  }

  void _showDriverInfo() {
    Navigator.of(context).pushNamed("/driver_info_screen");
  }
}
