import 'package:flutter/material.dart';

class SectionLabel extends StatelessWidget {
  final String label;

  const SectionLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Colors.grey,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.8,
      ),
    );
  }
}