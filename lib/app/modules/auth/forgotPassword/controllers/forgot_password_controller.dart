import 'package:deshi_mart_ecom_app/app/data/common/widgets/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/services/account_service.dart';
import '../../../../routes/app_pages.dart';

class ForgotPasswordController extends GetxController {


  final emailController = TextEditingController();
  final isLoading = false.obs;

  final AccountService accountService = AccountService();




  Future<void> sendOTP() async {
    final email = emailController.text;

    if (email.isEmpty) {
      customSnackbar(
        title: 'Error',
        message: 'Email is required',
        isError: true,
      );
      return;
    }



    try{
      isLoading.value = true;

      final response = await accountService.sendOtp(email);

      if (response.statusCode == 200) {

       final pref = await SharedPreferences.getInstance();
       pref.setString('email', email);

       customSnackbar(
          title: 'Success',
          message: 'OTP sent successfully',
          isError: false,
        );
        Get.toNamed(Routes.VERIFY_OTP);

      } else {
        customSnackbar(
          title: 'Error',
          message: 'Something went wrong',
          isError: true,
        );
      }


    } catch (e) {
      throw Exception("Error : $e");
    } finally {
      isLoading.value = false;
    }


  }




}
