import 'dart:convert';

import 'package:deshi_mart_ecom_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../data/auth_services/auth_session.dart';
import '../../../../data/common/widgets/custom_snackbar.dart';
import '../../../../data/services/auth_services.dart';

class RegisterController extends GetxController {
  final fullName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final isLoading = false.obs;

  final authServices = AuthServices();
  final authSession = AuthSession();


  Future<void> register() async {
    if (!validate()) return;

    try {
      isLoading.value = true;

      final response = await authServices.register({
        'full_name': fullName.text.trim(),
        'email': email.text.trim(),
        'password': password.text,
      });

      final data = jsonDecode(response.body);

      final token = data["data"]["token"];



      if (response.statusCode == 200 || response.statusCode == 201) {
       await authSession.saveToken(token);

       Get.offAllNamed(Routes.HOME);

        customSnackbar(
          title: "Success",
          message: "Account created successfully",
          isError: false,
        );
      } else {
        customSnackbar(title: "Error", message: data["errors"], isError: true);
      }
    } catch (e) {
      throw Exception("Error : $e");

    } finally {
      isLoading.value = false;
    }
  }

  bool validate() {
    if (fullName.text.trim().isEmpty) {
      customSnackbar(
        title: "Error",
        message: "Please enter your full name",
        isError: true,
      );
      return false;
    }

    if (email.text.isEmpty || !email.text.contains('@')) {
      customSnackbar(
        title: "Error",
        message: "Please enter a valid email",
        isError: true,
      );
      return false;
    }

    if (password.text.isEmpty) {
      customSnackbar(
        title: "Error",
        message: "Please enter your password",
        isError: true,
      );
      return false;
    }

    if (password.text.length < 6) {
      customSnackbar(
        title: "Error",
        message: "Password must be at least 6 characters",
        isError: true,
      );
      return false;
    }

    if (confirmPassword.text.isEmpty) {
      customSnackbar(
        title: "Error",
        message: "Please confirm your password",
        isError: true,
      );
      return false;
    }

    if (password.text != confirmPassword.text) {
      customSnackbar(
        title: "Error",
        message: "Password does not match",
        isError: true,
      );
      return false;
    }

    return true;
  }

  @override
  void onClose() {
    fullName.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.onClose();
  }
}
