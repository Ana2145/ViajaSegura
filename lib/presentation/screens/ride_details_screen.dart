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

                  final averageRating =
                      state.rides.first.driver?.averageRating ?? 0.0;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Promedio de calificaciones',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ...List.generate(5, (index) {
                                  return Icon(
                                    index < averageRating.round()
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Colors.amber,
                                    size: 36,
                                  );
                                }),
                                const SizedBox(width: 10),
                                Text(
                                  '(${averageRating.toStringAsFixed(1)})',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Text(
                              getMotivationalMessage(averageRating),
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 15),
                            const Divider(
                                thickness: 1.5, color: Color(0xFF773357)),
                            const SizedBox(height: 12),
                            Text(
                              'Desglose de calificaciones:',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      ...state.rides.map((ride) {
                        final rating = ride.driver?.averageRating ?? 0.0;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formatDate(ride.endedAt ?? ''),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      ...List.generate(5, (index) {
                                        return Icon(
                                          index < rating.round()
                                              ? Icons.star
                                              : Icons.star_border,
                                          color: Colors.amber,
                                          size: 20,
                                        );
                                      }),
                                      const SizedBox(width: 6),
                                      Text(
                                        '(${rating.toStringAsFixed(1)})',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  );
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
