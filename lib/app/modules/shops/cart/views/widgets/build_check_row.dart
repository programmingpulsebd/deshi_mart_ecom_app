import 'package:flutter/material.dart';

class BuildCheckRow extends StatelessWidget {
  const BuildCheckRow({
    super.key,
    required this.title,
    required this.trailingText,
  });

  final String title;
  final String trailingText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18,  fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          if (trailingText != null)
            Text(
              trailingText,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}