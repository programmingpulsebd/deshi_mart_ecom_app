import 'package:flutter/material.dart';

class LoginTittle extends StatelessWidget {
  const LoginTittle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Login", style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        Text(
          "Enter your emails and password",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
