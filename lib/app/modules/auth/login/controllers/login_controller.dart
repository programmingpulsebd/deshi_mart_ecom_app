import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/auth_services/auth_session.dart';
import '../../../../data/common/widgets/custom_snackbar.dart';
import '../../../../data/services/auth_services.dart';
import '../../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();

  final isLoading = false.obs;
  final authServices = AuthServices();
  final authSession = AuthSession();

  Future<void> login() async {
    if (!validate()) return;

    try {
      isLoading.value = true;

      final response = await authServices.login({
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
          message: "Account login successfully",
          isError: false,
        );
      } else {
        customSnackbar(title: "Error", message: data["errors"], isError: true);
      }




    } catch (e) {
      customSnackbar(
        title: "Error",
        message: "Something went wrong",
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
  }

  bool validate() {
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

    return true;
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
