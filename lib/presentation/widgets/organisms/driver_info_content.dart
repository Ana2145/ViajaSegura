import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/core/constants/app_colors.dart';
import '../atoms/info_input.dart';

class DriverInfoContent extends StatelessWidget {
  const DriverInfoContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 145,
            height: 145,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/images/driver_photo.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.lightBrown, width: 10),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Juan Perez",
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          const InfoInput(label: 'Número económico', value: "12345"),
          const InfoInput(label: "Organización", value: "Transportes Seguros"),
          const InfoInput(label: "Placas", value: "423-MYT"),
          const InfoInput(label: "Teléfono", value: "+52 55 1245 1234"),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
