import 'dart:convert';
import 'package:deshi_mart_ecom_app/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/common/widgets/custom_snackbar.dart';
import '../../../../data/services/account_service.dart';

class ResetPasswordController extends GetxController {
  final AccountService accountService = AccountService();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> resetPassword() async {
    if (newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      customSnackbar(
        title: 'Error',
        message: 'Password fields cannot be empty',
        isError: true,
      );
      return;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      customSnackbar(
        title: 'Error',
        message: 'Passwords do not match',
        isError: true,
      );
      return;
    }

    try {
      isLoading.value = true;
      final pref = await SharedPreferences.getInstance();
      final email = pref.getString('email');

      if (email == null || email.isEmpty) {
        customSnackbar(
          title: 'Error',
          message: 'Session expired. Please try again.',
          isError: true,
        );
        return;
      }

      final response = await accountService.resetPassword(
        email,
        newPasswordController.text,
        confirmPasswordController.text,
      );

      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        customSnackbar(
          title: 'Success',
          message: result['message'] ?? 'Password reset successfully',
          isError: false,
        );

        await pref.remove('email');
        Get.offAllNamed(Routes.LOGIN);
      } else {
        customSnackbar(
          title: 'Error',
          message: result['message'] ?? 'Something went wrong',
          isError: true,
        );
      }
    } catch (e) {
      customSnackbar(
        title: 'Error',
        message: 'Connection Error: $e',
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
