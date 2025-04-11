import 'package:flutter/material.dart';

class DriverCardInfo extends StatefulWidget {
  const DriverCardInfo({super.key});

  @override
  State<DriverCardInfo> createState() => _DriverCardInfoState();
}

class _DriverCardInfoState extends State<DriverCardInfo> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        onTap: _showDriverInfo,
        leading: const CircleAvatar(
          radius: 24,
          child: Icon(Icons.person),
        ),
        title: const Text("Nombre del conductor"),
        subtitle: const Text("Organización"),
        trailing: const Icon(Icons.info_outlined),
      ),
    );
  }

  void _showDriverInfo() {
    Navigator.of(context).pushNamed("/driver_info_screen");
  }
}
