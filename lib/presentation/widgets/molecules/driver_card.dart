import 'package:flutter/material.dart';
import '../atoms/icon_text.dart';

class DriverCard extends StatelessWidget {
  final String carName;
  final String plateNumber;
  final int passengers;
  final VoidCallback onTap;
  final VoidCallback onMoreInfo;

  const DriverCard({
    super.key,
    required this.carName,
    required this.plateNumber,
    required this.passengers,
    required this.onTap,
    required this.onMoreInfo,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.asset(
                'assets/images/car.png',
                width: 80,
                colorBlendMode: BlendMode.modulate,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      carName,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.secondaryHeaderColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Placas",
                      style: TextStyle(
                        color: theme.primaryColor.withOpacity(0.5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      plateNumber,
                      style: TextStyle(color: theme.secondaryHeaderColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                children: [
                  IconText(passengers: passengers),
                  ElevatedButton(
                    onPressed: onMoreInfo,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: theme.colorScheme.tertiary,
                      padding: const EdgeInsets.symmetric(
                        vertical: 0.0,
                        horizontal: 16.0,
                      ),
                    ),
                    child: Text(
                      "Ver más",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.secondaryHeaderColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
