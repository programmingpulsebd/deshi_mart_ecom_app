import 'package:deshi_mart_ecom_app/app/modules/auth/login/views/widgets/login_footer.dart';
import 'package:deshi_mart_ecom_app/app/modules/auth/login/views/widgets/login_title.dart';
import 'package:deshi_mart_ecom_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/common/widgets/custom_button.dart';
import '../../../../data/common/widgets/custom_text_field.dart';
import '../../../../utils/app_images.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

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

              const SizedBox(height: 60),
              LoginTittle(),

              const SizedBox(height: 40),

              CustomField(
                controller: controller.email,
                label: 'Email',
                hintText: 'example@gmail.com',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              CustomField(
                controller: controller.password,
                label: 'Password',
                hintText: '********',
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              const SizedBox(height: 15),


              Align(
                alignment: Alignment.centerRight,
                  child: TextButton( onPressed: () {
                    Get.toNamed(Routes.FORGOT_PASSWORD);
                  }, child: Text("Forgot Password?"),)

              ),


              const SizedBox(height: 30),

              Obx(
                () => CustomButton(
                  label: "Log In",
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.login();
                  },
                ),
              ),

              SizedBox(height: 20),

              LoginFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
