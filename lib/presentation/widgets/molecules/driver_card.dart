import 'package:flutter/material.dart';
import '../atoms/icon_text.dart';

class DriverCard extends StatelessWidget {
  final String carImage;
  final String carName;
  final String plateNumber;
  final int passengers;
  final VoidCallback onTap;
  final VoidCallback onMoreInfo;

  const DriverCard({
    super.key,
    required this.carImage,
    required this.carName,
    required this.plateNumber,
    required this.passengers,
    required this.onTap,
    required this.onMoreInfo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              SizedBox(
                //container img auto
                width: MediaQuery.of(context).size.width * 0.3,
                child: Image.asset(carImage, fit: BoxFit.contain),
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    //name & passengers
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          carName,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7C4A36)),
                          overflow:
                              TextOverflow.ellipsis, //evita desbordamientos
                        ),
                      ),
                      IconText(
                        icon: Icons.person,
                        text: "$passengers",
                        iconColor: Color(0xFF7C4A36),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    //plate & more info
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Placas",
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            plateNumber,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0XFF7C4A36),
                            ),
                          ),
                        ],
                      )),
                      TextButton(
                        onPressed: onMoreInfo,
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF7C4A36),
                          backgroundColor: Color(0xFFE2D5CA),
                          minimumSize: Size(0, 0),
                          padding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        ),
                        child: const Text("Más info",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
