import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/molecules/driver_card.dart';
import 'package:viaja_segura_movil/presentation/widgets/templates/map_bottom_panel.dart';

class DriversList extends StatefulWidget {
  const DriversList({super.key});

  @override
  State<DriversList> createState() => _DriversListState();
}

class _DriversListState extends State<DriversList> {
  List<Map<String, dynamic>> drivers = [
    {
      "carName": "Toyota Corolla",
      "plateNumber": "ABC-123",
      "passengers": 4,
      "color": "#FF0000",
    },
    {
      "carName": "Honda Civic",
      "plateNumber": "XYZ-789",
      "passengers": 3,
      "color": "#00FF00",
    },
    {
      "carName": "Honda Civic",
      "plateNumber": "XYZ-789",
      "passengers": 3,
      "color": "#0000FF",
    },
    {
      "carName": "Honda Civic",
      "plateNumber": "XYZ-789",
      "passengers": 3,
      "color": "#FFFF00",
    },
    {
      "carName": "Honda Civic",
      "plateNumber": "XYZ-789",
      "passengers": 3,
      "color": "#00FFFF",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MapBottomPanel(
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (final driver in drivers)
              DriverCard(
                carName: driver["carName"],
                plateNumber: driver["plateNumber"],
                passengers: driver["passengers"],
                color: driver["color"],
              ),
          ],
        ),
      ),
    );
  }
}
