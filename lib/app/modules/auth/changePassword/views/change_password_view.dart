import 'package:deshi_mart_ecom_app/app/data/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/common/widgets/custom_text_field.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CustomField(
                label: 'Old Password',
                hintText: "*******",
                obscureText: true,
                controller: controller.oldPasswordController,
              ),

              SizedBox(height: 15),

              CustomField(
                label: 'New Password',
                hintText: "*******",
                obscureText: true,
                controller: controller.newPasswordController,
              ),

              SizedBox(height: 15),

              CustomField(
                label: 'Confirm Password',
                hintText: "*******",
                obscureText: true,
                controller: controller.confirmPasswordController,
              ),
              SizedBox(height: 20),

              Obx(
                () => CustomButton(
                    isLoading: controller.isLoading.value,
                    label: "Change Password", onPressed: () {
                      controller.changePassword();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
