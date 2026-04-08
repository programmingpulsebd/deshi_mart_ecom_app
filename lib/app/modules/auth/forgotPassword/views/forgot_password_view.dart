import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/common/widgets/custom_button.dart';
import '../../../../data/common/widgets/custom_text_field.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.19),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(Icons.lock, size: 44, color: scheme.primary),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Forgot Password?",
              style: theme.textTheme.titleLarge?.copyWith(),
            ),
            const SizedBox(height: 8),
            Text(
              "Enter your email address. We will send you an OTP to reset your password.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurface.withValues(alpha: .65),
              ),
            ),
            const SizedBox(height: 30),

            CustomField(
              controller: controller.emailController,
              label: 'Email',
              hintText: 'example@gmail.com',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),

            Obx(() {
              return CustomButton(
                label: "Send OTP",
                onPressed: () {
                  controller.sendOTP();
                },
                isLoading: controller.isLoading.value,
              );
            }),
          ],
        ),
      ),
    );
  }
}
