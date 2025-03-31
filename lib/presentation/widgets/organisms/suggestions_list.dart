import 'package:flutter/material.dart';

class SuggestionsList extends StatelessWidget {
  final List<String> suggestions;
  final bool isLoading;
  final ValueChanged<String> onSuggestionSelected;

  const SuggestionsList({
    super.key,
    required this.suggestions,
    required this.isLoading,
    required this.onSuggestionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isLoading)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          )
        else if (suggestions.isEmpty)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: Text('No hay sugerencias disponibles')),
          )
        else
          ...suggestions.map(
                (suggestion) => ListTile(
              leading: const Icon(Icons.location_on, size: 20),
              title: Text(suggestion),
              dense: true,
              visualDensity: const VisualDensity(vertical: -4),
              onTap: () => onSuggestionSelected(suggestion),
            ),
          ),
      ],
    );
  }
}
