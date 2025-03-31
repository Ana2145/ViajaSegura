import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/organisms/driver_info_content.dart';
import 'package:viaja_segura_movil/presentation/widgets/templates/auth_template.dart';

class DriverInfoScreen extends StatelessWidget {
  const DriverInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthTemplate(title: '', form: const DriverInfoContent());
  }
}
