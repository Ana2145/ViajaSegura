import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:viaja_segura_movil/data/cubits/rides/rides_cubit.dart';
import 'package:viaja_segura_movil/data/services/map_location_services.dart';

class DriverRidesList extends StatelessWidget {
  const DriverRidesList({super.key});

  String formatDate(String dateStr) {
    final date = DateTime.parse(dateStr);
    return DateFormat('dd MMM yyyy, HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<RidesCubit, RidesState>(
      builder: (context, state) {
        if (state is RidesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RidesLoaded) {
          if (state.rides.isEmpty) {
            return const Center(
                child: Text('No se han realizado viajes actualmente.'));
          }

          final completeRides = state.rides
              .where((ride) =>
                  ride.endedAt != null && ride.endedAt.toString().isNotEmpty)
              .toList();

          if (completeRides.isEmpty) {
            return const Center(
              child: Text('No hay viajes finalizados para mostrar.'),
            );
          }

          return Column(
            children: completeRides.map((ride) {
              return _RideItem(
                ride: ride,
                theme: theme,
                formatDate: formatDate,
              );
            }).toList(),
          );
        } else if (state is RidesError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _RideItem extends StatefulWidget {
  final dynamic ride;
  final ThemeData theme;
  final String Function(String) formatDate;

  const _RideItem({
    required this.ride,
    required this.theme,
    required this.formatDate,
  });

  @override
  State<_RideItem> createState() => _RideItemState();
}

class _RideItemState extends State<_RideItem> {
  bool _showDestination = false;
  String _originAddress = '';
  String _destinationAddress = '';

  final MapLocationServices _mapService = MapLocationServices();

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    final origin = await _mapService.getAddressFromLatLng(
        widget.ride.originLat, widget.ride.originLng);
    final destination = await _mapService.getAddressFromLatLng(
        widget.ride.destinationLat, widget.ride.destinationLng);

    setState(() {
      _originAddress = origin;
      _destinationAddress = destination;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ride = widget.ride;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: widget.theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: widget.theme.primaryColor),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    const TextSpan(text: 'Pasajera '),
                    TextSpan(
                      text: ride.passenger.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                setState(() {
                  _showDestination = !_showDestination;
                });
              },
              child: Row(
                children: [
                  const Icon(Icons.arrow_circle_down_rounded,
                      color: Color(0xFFBC9B73), size: 25),
                  const SizedBox(width: 8),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Origen: ',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text: _originAddress.isEmpty
                                ? 'Cargando dirección...'
                                : _originAddress),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'con inicio el día: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: widget.formatDate(ride.startedAt)),
                ],
              ),
            ),
            if (_showDestination) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.arrow_circle_up_rounded,
                      color: Color(0xFF773357), size: 20),
                  const SizedBox(width: 8),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Destino: ',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: _originAddress.isEmpty
                              ? 'Cargando dirección...'
                              : _destinationAddress,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'con finalización el día: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: widget.formatDate(ride.endedAt)),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Precio: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '\$${ride.price.toStringAsFixed(2)}',
                      ),
                    ],
                  ),
                ),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < ride.driver.averageRating.round()
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                      size: 20,
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
