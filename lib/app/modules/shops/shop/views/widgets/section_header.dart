import 'package:flutter/material.dart';

import '../../../../../utils/themes/app_color.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title,  this.onTap,  this.text});

  final String title;
  final VoidCallback? onTap;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          InkWell(
            onTap: onTap,
            child: Text(
              text ?? "",
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(color: AppColor.primary),
            ),
          ),
        ],
      ),
    );
  }
}
