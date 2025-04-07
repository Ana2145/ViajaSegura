import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => {
            Scaffold.of(context).openDrawer(),
          },
          icon: Icon(Icons.menu, size: 32, color: theme.primaryColor),
        ),
        actions: [
          InkWell(
            onTap: () => Navigator.of(context).pushNamed('/profile_screen'),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.account_circle,
                size: 32,
                color: theme.primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
