import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/car_image.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/icon_text.dart';
import 'package:viaja_segura_movil/presentation/widgets/organisms/driver_info_bottom_sheet.dart';

class DriverCard extends StatefulWidget {
  final String carName;
  final String plateNumber;
  final String color;
  final int passengers;

  const DriverCard({
    super.key,
    required this.carName,
    required this.plateNumber,
    required this.color,
    required this.passengers,
  });

  @override
  State<DriverCard> createState() => _DriverCardState();
}

class _DriverCardState extends State<DriverCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CarImage(color: widget.color),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.carName,
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
                    widget.plateNumber,
                    style: TextStyle(color: theme.secondaryHeaderColor),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              children: [
                IconText(passengers: widget.passengers),
                ElevatedButton(
                  onPressed: _bottomSheetDriver,
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _bottomSheetDriver() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return DriverInfoBottomSheet(
          carName: widget.carName,
          plateNumber: widget.plateNumber,
          passengers: widget.passengers,
          color: widget.color,
        );
      },
    );
  }
}
