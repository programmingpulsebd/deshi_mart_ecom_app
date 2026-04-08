import 'package:deshi_mart_ecom_app/app/data/common/widgets/custom_button.dart';
import 'package:deshi_mart_ecom_app/app/data/common/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/verify_otp_controller.dart';

class VerifyOtpView extends GetView<VerifyOtpController> {
  const VerifyOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('OTP Verification')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
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
            Text("Verify OTP", style: theme.textTheme.titleLarge?.copyWith()),
            const SizedBox(height: 8),
            Text(
              "An OTP has been sent to your email address for password reset.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurface.withValues(alpha: .65),
              ),
            ),
            const SizedBox(height: 30),

            CustomField(
              hintText: controller.emailController.text,
              label: "Email Account",
              keyboardType: TextInputType.emailAddress,
              readOnly: true,
            ),

            const SizedBox(height: 15),

            CustomField(
              hintText: "6-Digit OTP",
              label: "Enter OTP Code",
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),

            Obx(
              () => CustomButton(
                label: "Verify OTP",
                onPressed: () {
                  controller.verifyOTP();
                },
                isLoading: controller.isLoading.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
