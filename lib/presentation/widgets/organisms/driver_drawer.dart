import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viaja_segura_movil/data/cubits/auth/auth_cubit.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/logo.dart';

class DriverDrawer extends StatefulWidget {
  const DriverDrawer({super.key});

  @override
  State<DriverDrawer> createState() => _DriverDrawerState();
}

class _DriverDrawerState extends State<DriverDrawer> {
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
            const Icon(Icons.local_taxi),
            'Historial de viajes',
            '/driver_trip_history',
          ),
          _buildOption(
            const Icon(Icons.star),
            'Calificaciones',
            '/driver_ratings',
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
