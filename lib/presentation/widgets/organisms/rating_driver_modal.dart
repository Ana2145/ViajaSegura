import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/core/constants/app_colors.dart';

class RatingDriverModal extends StatefulWidget {
  const RatingDriverModal({super.key});

  @override
  _RatingDriverModalState createState() => _RatingDriverModalState();
}

class _RatingDriverModalState extends State<RatingDriverModal> {
  int _selectedStars = 0;

  void _onStarTap(int index) {
    setState(() {
      _selectedStars = index + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Calificar conductor(a)",
                style: theme.textTheme.headlineMedium),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () => _onStarTap(index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Icon(
                      Icons.star,
                      size: 30,
                      color: index < _selectedStars
                          ? Colors.orange
                          : AppColors.contentColor.withOpacity(0.3),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Omitir",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
