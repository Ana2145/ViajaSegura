import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TripTimeline extends StatefulWidget {
  const TripTimeline({super.key});

  @override
  State<TripTimeline> createState() => _TripTimelineState();
}

class _TripTimelineState extends State<TripTimeline> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0,
            isFirst: true,
            indicatorStyle: IndicatorStyle(
              padding: const EdgeInsets.only(right: 8.0),
              indicatorXY: 0.11,
              width: 12,
              height: 12,
              color: theme.colorScheme.secondary,
            ),
            endChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Inicio',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Teatro Ocampo, Calle Gral. H. Galeana 2, Cuernavaca Centro, Centro, 62000 Cuernavaca, Mor.',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0,
            isLast: true,
            indicatorStyle: IndicatorStyle(
              padding: const EdgeInsets.only(right: 8.0),
              indicatorXY: 0.18,
              width: 12,
              height: 12,
              color: theme.colorScheme.primary,
            ),
            endChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Destino',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Ex Hacienda de Temixco Waterpark, 62580, 62582 Temixco, Mor.',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
