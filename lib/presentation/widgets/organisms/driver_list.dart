import 'package:flutter/material.dart';
import '../molecules/driver_card.dart';

class DriverList extends StatelessWidget {
  final List<Map<String, dynamic>> drivers;
  final void Function(int) onSelect;
  const DriverList({super.key, required this.drivers, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: drivers.length,
            itemBuilder: (context, index) {
              final driver = drivers[index];
              return DriverCard(
                carImage: driver['carImage'],
                carName: driver['carName'],
                plateNumber: driver['plateNumber'],
                passengers: driver['passengers'],
                onTap: () => onSelect(index),
                onMoreInfo: () => print("Más info de ${driver['carName']}"),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => print('Confirmar seleccion'),
            child: const Text("Confirmar"),
          ),
        ),
      ],
    );
  }
}
