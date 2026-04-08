import 'package:flutter/material.dart';

class RegisterTittle extends StatelessWidget {
  const RegisterTittle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Sign Up", style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        Text(
          "Enter your credentials to continue",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}