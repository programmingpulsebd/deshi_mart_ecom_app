
import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[300]),
        const SizedBox(height: 16),
        Text('Your cart is empty',
            style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey)),
        const SizedBox(height: 8),
      ],
    );
  }
}