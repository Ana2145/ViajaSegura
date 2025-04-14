import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:viaja_segura_movil/data/cubits/rides/rides_cubit.dart';
import 'package:viaja_segura_movil/data/repositories/ride_repository.dart';
import 'package:viaja_segura_movil/presentation/widgets/templates/profile_template.dart';

class RideDetailsScreen extends StatelessWidget {
  const RideDetailsScreen({super.key});

  String formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy, HH:mm').format(date);
    } catch (_) {
      return 'Fecha inválida';
    }
  }

  String getMotivationalMessage(double averageRating) {
    if (averageRating >= 4.5) {
      return '¡Excelente! Sigue así, estás haciendo un gran trabajo.';
    } else if (averageRating >= 3.0) {
      return 'Bien hecho. Siempre hay espacio para mejorar.';
    } else {
      return '¡Ánimo! Puedes mejorar, sigue esforzándote.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RidesCubit(RideRepository())..fetchRides(),
      child: ProfileTemplate(
        title: 'Calificaciones de viajes',
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<RidesCubit, RidesState>(
              builder: (context, state) {
                if (state is RidesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is RidesLoaded) {
                  if (state.rides.isEmpty) {
                    return const Center(
                        child: Text('No hay viajes disponibles.'));
                  }

                  return ListView.separated(
                      shrinkWrap: true,
                      itemCount: state.rides.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final ride = state.rides[index];
                        final driver = ride.driver;

                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    'Promedio de Calificaciones: ${driver?.averageRating?.toStringAsFixed(1) ?? 'No disponible'}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Center(
                                  child: Text(
                                    getMotivationalMessage(
                                        driver?.averageRating ?? 0),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Divider(thickness: 1.5),
                                const SizedBox(height: 12),
                                Text(
                                  'Desglose de calificaciones:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Calificación:',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${driver?.averageRating?.toStringAsFixed(1) ?? 'N/A'}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Fecha del viaje:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(formatDate(ride.endedAt ?? '')),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                } else if (state is RidesError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
