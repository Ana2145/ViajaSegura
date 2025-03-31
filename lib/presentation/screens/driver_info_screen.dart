import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/templates/auth_template.dart';

class DriverInfoScreen extends StatefulWidget {
  const DriverInfoScreen({super.key});

  @override
  State<DriverInfoScreen> createState() => _DriverInfoScreenState();
}

class _DriverInfoScreenState extends State<DriverInfoScreen> {
  Widget _buildDriverInfo(String label, String value) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Text(
          label,
          style:
              theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Text(value, style: theme.textTheme.bodyLarge),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthTemplate(
      title: 'Detalles del conductor',
      height: 32.0,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Theme.of(context).colorScheme.tertiary,
            ),
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                "https://www.thispersondoesnotexist.com/",
                width: 200,
                height: 200,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            'SIMÓN RANGEL OLMOS',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 32.0),
          _buildDriverInfo("NÚMERO DE ECONÓMICO:", "123456"),
          const SizedBox(height: 8.0),
          _buildDriverInfo("ORGANIZACIÓN:", "LÍNEA VICTORIA"),
          const SizedBox(height: 8.0),
          _buildDriverInfo("TELÉFONO:", "7775630240"),
          const SizedBox(height: 8.0),
          _buildDriverInfo("PLACAS:", "ABC1234"),
        ],
      ),
    );
  }
}
