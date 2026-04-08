import 'package:deshi_mart_ecom_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/common/widgets/custom_snackbar.dart';
import '../../../../data/services/account_service.dart';

class VerifyOtpController extends GetxController {
  final AccountService accountService = AccountService();

  var isLoading = false.obs;
  final emailController = TextEditingController();
  final otpController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadSavedEmail();
  }

  void loadSavedEmail() async {
    final pref = await SharedPreferences.getInstance();
    final email = pref.getString('email');

    if (email != null) {
      emailController.text = email;
    } else {
      Get.back();
    }
  }


  Future<void> verifyOTP() async {
    final email = emailController.text;
    final otp = otpController.text;

    try{
      isLoading.value = true;

      final response = await accountService.verifyOTP(email, otp);

      if (response.statusCode == 200) {
       customSnackbar(
          title: 'Success',
          message: 'OTP verified successfully',
          isError: false,
        );
       Get.toNamed(Routes.RESET_PASSWORD);

      } else {
        customSnackbar(
          title: 'Error',
          message: 'Something went wrong',
          isError: true,
        );
      }


    } catch(e){
      throw Exception("Error : $e");
    } finally {
      isLoading.value = false;
    }



  }


}
