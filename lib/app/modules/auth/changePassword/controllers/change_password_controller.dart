import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/common/widgets/custom_snackbar.dart';
import '../../../../data/services/account_service.dart';

class ChangePasswordController extends GetxController {

  final changePasswordFormKey = GlobalKey<FormState>();

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;

  final AccountService accountService = AccountService();



  Future<void> changePassword() async {
    final old = oldPasswordController.text;
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (old.isEmpty) {
      customSnackbar(title: "Error", message: "Old password is required", isError: true);
      return;
    }
    if (newPassword.isEmpty) {
      customSnackbar(title: "Error", message: "New password is required", isError: true);
      return;
    }
    if (confirmPassword.isEmpty) {
      customSnackbar(title: "Error", message: "Confirm password is required", isError: true);
      return;
    }
    if (newPassword != confirmPassword) {
      customSnackbar(title: "Error", message: "Password does not match", isError: true);
      return;
    }

    try {
      isLoading.value = true;

      final data = {
        "current_password": old,
        "new_password": newPassword,
        "new_password_confirmation": confirmPassword,
      };

      final response = await accountService.changePassword(data);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        customSnackbar(
          title: "Success",
          message: result["message"] ?? "Password changed successfully",
          isError: false,
        );

        oldPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();

      } else {
        customSnackbar(
          title: "Error",
          message: result["message"] ?? "Something went wrong",
          isError: true,
        );
      }

    } catch (e) {
      customSnackbar(
        title: "Error",
        message: "An unexpected error occurred",
        isError: true,
      );
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }










}
