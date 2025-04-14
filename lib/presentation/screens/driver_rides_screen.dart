import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viaja_segura_movil/data/cubits/rides/rides_cubit.dart';
import 'package:viaja_segura_movil/data/repositories/ride_repository.dart';
import 'package:viaja_segura_movil/presentation/widgets/organisms/driver_rides_list.dart';
import 'package:viaja_segura_movil/presentation/widgets/templates/profile_template.dart';

class DriverRidesScreen extends StatelessWidget {
  const DriverRidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RidesCubit(RideRepository())..fetchRides(),
      child: const ProfileTemplate(
        title: 'Historial de viajes',
        child: DriverRidesList(),
      ),
    );
  }
}
