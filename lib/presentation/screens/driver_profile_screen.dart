import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viaja_segura_movil/data/cubits/driver/driver_cubit.dart';
import 'package:viaja_segura_movil/data/repositories/driver_repository.dart';
import 'package:viaja_segura_movil/presentation/widgets/organisms/driver_profile.form.dart';
import 'package:viaja_segura_movil/presentation/widgets/templates/profile_template.dart';

class DriverProfileScreen extends StatelessWidget {
  const DriverProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DriverCubit(DriverRepository()),
      child: const ProfileTemplate(
        title: 'Profile',
        child: DriverProfileForm(),
      ),
    );
  }
}
