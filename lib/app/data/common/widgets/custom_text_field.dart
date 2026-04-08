import 'package:flutter/material.dart';

import '../../../utils/themes/app_color.dart';

class CustomField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final int? maxLines;
  final TextEditingController? controller;
  final bool readOnly;

  const CustomField({
    super.key,
    required this.label,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
    this.controller,
    this.readOnly = false,
  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        TextFormField(
          readOnly: widget.readOnly,
          controller: widget.controller,
          obscureText: widget.obscureText ? isPassword : false,
          keyboardType: widget.keyboardType,
          maxLines: widget.obscureText ? 1 : widget.maxLines,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            suffixIcon: widget.obscureText
                ? IconButton(
              icon: Icon(isPassword ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
              onPressed: () => setState(() => isPassword = !isPassword),
            )
                : null,
            hintText: widget.hintText,
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[400]),
            filled: true,
            fillColor: Theme.of(context).cardColor,
            contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor.primaryDark, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor.primary, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor.primaryDark.withOpacity(0.5), width: 1),
            ),
          ),
        ),
      ],
    );
  }
}