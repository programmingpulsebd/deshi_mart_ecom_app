import 'package:deshi_mart_ecom_app/app/data/common/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../data/common/widgets/custom_button.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});
  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.19),
                shape: BoxShape.circle,
              ),
              child: Center(child: Icon(Icons.lock, size: 44, color: scheme.primary)),
            ),
            const SizedBox(height: 24),
            Text(
              "Reset Your Password",
              style: theme.textTheme.titleLarge?.copyWith(),
            ),
            const SizedBox(height: 8),
            Text(
              "Please enter a new password to secure your account.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurface.withValues(alpha: .65),
              ),
            ),
            const SizedBox(height: 30),

            const SizedBox(height: 20),

            CustomField(
              label: "New Password",
              hintText: "Enter new password",
              controller: controller.newPasswordController,
            ),
            const SizedBox(height: 15),
            CustomField(
              label: "Confirm Password",
              hintText: "Confirm your password",
              controller: controller.confirmPasswordController,
            ),
            const SizedBox(height: 20),

            Obx(
                  () => CustomButton(
                label: "Reset Password",
                isLoading: controller.isLoading.value,
                onPressed: () {
                  controller.resetPassword();
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}