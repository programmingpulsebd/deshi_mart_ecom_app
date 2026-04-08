import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/themes/app_color.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String)? onChanged;
  final String? hintText;
  const CustomSearchBar({super.key, this.onChanged, this.hintText});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: isDark
            ? []
            : [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        onChanged: onChanged,
        cursorColor: AppColor.primary,
        style: TextStyle(color: theme.textTheme.bodyLarge?.color),
        decoration: InputDecoration(
          filled: true,
          fillColor: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : theme.cardColor,

          hintText:hintText,
          hintStyle: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey),

          prefixIcon: Icon(
            Iconsax.search_normal,
            size: 20,
            color: isDark ? Colors.white70 : Colors.grey,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.15)
                  : theme.dividerColor.withValues(alpha: 0.2),
              width: 1,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColor.primary, width: 1.5),
          ),

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
        ),
      ),
    );
  }
}
