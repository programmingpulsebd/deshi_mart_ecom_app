import 'package:flutter/material.dart';

import '../../../../../utils/themes/app_color.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.iconColor,
    this.titleColor,
    this.showDivider = true,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? titleColor;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            decoration: BoxDecoration(
              color: (iconColor ?? AppColor.primary).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: iconColor ?? AppColor.primary),
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: titleColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: Colors.grey[400],
          ),
          onTap: onTap,
        ),
        if (showDivider)
          Divider(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
            thickness: 0.4,
            indent: 20,
            endIndent: 20,
            height: 0,
          ),
      ],
    );
  }
}