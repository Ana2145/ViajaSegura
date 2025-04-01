import 'package:flutter/material.dart';

class LocationTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Widget prefixIcon;
  final VoidCallback? onClear;
  final bool isLoading;
  final bool showSuggestions;
  final ValueChanged<String> onChanged;
  final VoidCallback onTap;

  const LocationTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.prefixIcon,
    this.onClear,
    this.isLoading = false,
    this.showSuggestions = false,
    required this.onChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
              hintText: label,
              prefixIcon: prefixIcon,
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: onClear,
              )),
          onChanged: onChanged,
          onTap: onTap,
        ),
      ],
    );
  }
}
