import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viaja_segura_movil/data/cubits/driver/driver.availability.cubit.dart';
import 'package:viaja_segura_movil/data/cubits/driver/driver_availability.state.dart';

class DriverAvailabilityButton extends StatefulWidget {
  const DriverAvailabilityButton({super.key});

  @override
  State<DriverAvailabilityButton> createState() =>
      _DriverAvailabilityButtonState();
}

class _DriverAvailabilityButtonState extends State<DriverAvailabilityButton> {
  int dotCount = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<DriverAvailabilityCubit>();
    cubit.fetchAvailability();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startWaitingAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      setState(() {
        dotCount = (dotCount + 1) % 4;
      });
    });
  }

  void _stopWaitingAnimation() {
    _timer?.cancel();
    setState(() {
      dotCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<DriverAvailabilityCubit, DriverAvailabilityState>(
      listener: (context, state) {
        if (state is DriverAvailable) {
          _startWaitingAnimation();
        } else {
          _stopWaitingAnimation();
        }
      },
      builder: (context, state) {
        if (state is DriverAvailabilityLoading) {
          return ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const CircularProgressIndicator(),
          );
        } else if (state is DriverAvailable) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'En espera de viajes${'.' * dotCount}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  context.read<DriverAvailabilityCubit>().toggleAvailability();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Desactivar disponibilidad',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          );
        } else if (state is DriverUnavailable) {
          return ElevatedButton(
            onPressed: () {
              context.read<DriverAvailabilityCubit>().toggleAvailability();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text(
              'Listo para viajar',
              style: TextStyle(fontSize: 16),
            ),
          );
        } else if (state is DriverAvailabilityError) {
          return Text('Error: ${state.message}');
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
