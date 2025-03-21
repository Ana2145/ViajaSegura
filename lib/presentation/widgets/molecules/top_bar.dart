import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => print('Abrir menú'),
            icon: const Icon(
              Icons.menu,
              size: 30,
              color: Color(0xAA773357),
            ),
          ),
          const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.account_circle,
              size: 35,
              color: Color(0xAA773357),
            ),
          ),
        ],
      ),
    );
  }
}
