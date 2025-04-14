import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:viaja_segura_movil/data/cubits/rides/rides_cubit.dart';

class DriverRidesList extends StatelessWidget {
  const DriverRidesList({super.key});

  String formatDate(String dateStr) {
    final date = DateTime.parse(dateStr);
    return DateFormat('dd MMM yyyy, HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<RidesCubit, RidesState>(
        builder: (context, state) {
          if (state is RidesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RidesLoaded) {
            if (state.rides.isEmpty) {
              return const Center(child: Text('No hay viajes disponibles.'));
            }

            return SingleChildScrollView(
              child: Column(
                children: state.rides.map((ride) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Card(
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
                                'Pasajera: ${ride.passenger.name}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('🕓 Inicio: ${formatDate(ride.startedAt)}'),
                            Text('🕓 Fin: ${formatDate(ride.endedAt)}'),
                            const SizedBox(height: 8),
                            Text(
                                '📍 Origen: (${ride.originLat}, ${ride.originLng})'),
                            Text(
                                '📍 Destino: (${ride.destinationLat}, ${ride.destinationLng})'),
                            const SizedBox(height: 8),
                            Text(
                                '💰 Precio: \$${ride.price.toStringAsFixed(2)}'),
                            const SizedBox(height: 8),
                            Text(
                                '⭐ Rating promedio: ${ride.driver.averageRating}'),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          } else if (state is RidesError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
