import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/molecules/driver_card_info.dart';
import 'package:viaja_segura_movil/presentation/widgets/molecules/rating_card_info.dart';
import 'package:viaja_segura_movil/presentation/widgets/organisms/trip_timeline.dart';
import 'package:viaja_segura_movil/presentation/widgets/templates/drawer_bottom_card_template.dart';
import 'package:viaja_segura_movil/presentation/widgets/templates/profile_template.dart';

class TripHistoryDetailsScreen extends StatefulWidget {
  const TripHistoryDetailsScreen({super.key});

  @override
  State<TripHistoryDetailsScreen> createState() {
    return _TripHistoryDetailsScreenState();
  }
}

class _TripHistoryDetailsScreenState extends State<TripHistoryDetailsScreen> {
  double? rating;

  @override
  Widget build(BuildContext context) {
    return ProfileTemplate(
      title: 'Detalles del viaje',
      child: DrawerBottomCardTemplate(
        children: [
          const SizedBox(height: 32),
          _buildSectionTitle(context, 'Detalles del viaje'),
          const TripTimeline(),
          const SizedBox(height: 32),
          _buildSectionTitle(context, 'Detalles del conductor'),
          const DriverCardInfo(),
          const SizedBox(height: 32),
          _buildSectionTitle(context, 'Calificación al conductor'),
          RatingCardInfo(
            rating: rating,
            onRatingChanged: (newRating) {
              setState(() => rating = newRating);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Text(
      title,
      style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
