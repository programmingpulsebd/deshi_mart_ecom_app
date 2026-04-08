import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LatestProductCardShimmer extends StatelessWidget {
  const LatestProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final baseColor = theme.brightness == Brightness.dark
        ? Colors.grey.shade800
        : Colors.grey.shade300;

    final highlightColor = theme.brightness == Brightness.dark
        ? Colors.grey.shade700
        : Colors.grey.shade100;

    Widget box({
      double? height,
      double? width,
      double radius = 12,
    }) {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(radius),
        ),
      );
    }

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: theme.dividerColor.withValues(alpha: 0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            box(
              height: 110,
              width: double.infinity,
              radius: 12,
            ),
            const SizedBox(height: 8),
            box(height: 14, width: 100, radius: 8),
            const SizedBox(height: 6),
            box(height: 12, width: 70, radius: 8),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                box(height: 18, width: 50, radius: 8),
                box(height: 36, width: 36, radius: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}