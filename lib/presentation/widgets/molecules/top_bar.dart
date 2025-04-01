import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => {},
          icon: const Icon(
            Icons.menu,
            size: 30,
            color: Color(0xFF773357),
          ),
        ),
        actions: const [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.account_circle,
              size: 35,
              color: Color(0xFF773357),
            ),
          )
        ],
      ),
    );
  }
}
