import 'package:deshi_mart_ecom_app/app/modules/auth/register/views/widgets/register_footer.dart';
import 'package:deshi_mart_ecom_app/app/modules/auth/register/views/widgets/register_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/common/widgets/custom_button.dart';
import '../../../../data/common/widgets/custom_text_field.dart';
import '../../../../utils/app_images.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              Center(
                child: Image.asset(
                  AppImages.mainLogo,
                  fit: BoxFit.contain,
                  height: 60,
                ),
              ),

              const SizedBox(height: 50),
              RegisterTittle(),

              const SizedBox(height: 40),

              CustomField(
                controller: controller.fullName,
                label: 'Full Name',
                hintText: 'Abdul Rahman',
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 15),

              CustomField(
                controller: controller.email,
                label: 'Email',
                hintText: 'example@gmail.com',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),

              CustomField(
                controller: controller.password,
                label: 'Password',
                hintText: '********',
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),

              const SizedBox(height: 15),

              CustomField(
                controller: controller.confirmPassword,
                label: 'Confirm Password',
                hintText: '********',
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),

              const SizedBox(height: 30),

              Obx(() {
                return CustomButton(
                  label: "Sign Up",
                  onPressed: controller.register,
                  isLoading: controller.isLoading.value,
                );
              }),

              SizedBox(height: 20),

              RegisterFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
