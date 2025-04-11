import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/custom_button.dart';
import 'package:viaja_segura_movil/presentation/widgets/templates/map_bottom_panel.dart';

class RatingCardInfo extends StatelessWidget {
  final double? rating;
  final Function(double) onRatingChanged;

  const RatingCardInfo({
    super.key,
    required this.rating,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        onTap: () => _openBottomSheetRating(context),
        leading: const Icon(Icons.star),
        title: rating == null || rating == 0
            ? const Text("Sin calificación")
            : Text("Calificación: $rating"),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }

  void _openBottomSheetRating(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        double? tempRating;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return MapBottomPanel(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "¿Cómo calificarías al conductor?",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: StarRating(
                      size: 40.0,
                      rating: tempRating ?? 0.0,
                      color: Colors.orange,
                      borderColor: Colors.grey,
                      allowHalfRating: true,
                      starCount: 5,
                      onRatingChanged: (newRating) {
                        setModalState(() {
                          tempRating = newRating;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  if ((tempRating ?? 0) > 0)
                    Text(
                      "Tu calificación es: ${tempRating!.toStringAsFixed(1)}",
                      style: const TextStyle(fontSize: 30.0),
                    ),
                  const SizedBox(height: 20),
                  CustomButton(
                    onPressed: () {
                      if (tempRating != null && tempRating! > 0) {
                        onRatingChanged(tempRating!);
                      }
                      Navigator.pop(context);
                    },
                    text: "Enviar calificación",
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
