import 'package:flutter/material.dart';
import '../widgets/organisms/driver_list.dart';

class DriverListScreen extends StatelessWidget {
  final void Function() onClose;

  const DriverListScreen({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    List<Map<String, dynamic>> drivers = [
      {
        "carImage": "assets/images/car1.png",
        "carName": "Toyota Corolla",
        "plateNumber": "ABC-123",
        "passengers": 4
      },
      {
        "carImage": "assets/images/car2.png",
        "carName": "Honda Civic",
        "plateNumber": "XYZ-789",
        "passengers": 3
      }
    ];

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: screenWidth,
        constraints: BoxConstraints(
          maxHeight: screenHeight * 0.5,
        ),
        decoration: const BoxDecoration(
          color: Color(0xFFEDEAEC),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
//          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 8,
            ),
            Center(
              child: Container(
                width: 100,
                height: 7,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2D5CA),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Expanded(
              child: DriverList(
                  drivers: drivers,
                  onSelect: (index) => print("Seleccionado: $index")),
            ),
          ],
        ),
      ),
    );
  }
}
