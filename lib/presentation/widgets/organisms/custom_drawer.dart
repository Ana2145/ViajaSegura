import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viaja_segura_movil/data/cubits/auth/auth_cubit.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/logo.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Widget _buildOption(Widget icon, String title, String route) {
    return ListTile(
      leading: icon,
      title: Text(title),
      onTap: () => Navigator.of(context).pushNamed(route),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: theme.primaryColor),
            child: const Center(child: Logo()),
          ),
          _buildOption(
            Badge.count(count: 3, child: const Icon(Icons.notifications)),
            'Notificaciones',
            '/notifications_screen',
          ),
          _buildOption(
            const Icon(Icons.local_taxi),
            'Historial de viajes',
            '/trip_history_screen',
          ),
          _buildOption(
            const Icon(Icons.qr_code),
            'Escanear código QR',
            '/qr_code_scanning_screen',
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Cerrar sesión'),
            onTap: _logout,
          ),
        ],
      ),
    );
  }

  void _logout() {
    context.read<AuthCubit>().logout();
    Navigator.of(context, rootNavigator: true).pushNamed('/');
  }
}
