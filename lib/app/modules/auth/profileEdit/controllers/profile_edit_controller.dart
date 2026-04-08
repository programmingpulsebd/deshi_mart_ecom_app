import 'dart:convert';
import 'dart:io';

import 'package:deshi_mart_ecom_app/app/modules/auth/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../data/common/widgets/custom_snackbar.dart';
import '../../../../data/model/user_model.dart';
import '../../../../data/services/auth_services.dart';

class ProfileEditController extends GetxController {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController customerNameController;
  late TextEditingController fullAddressController;

  late UserData userData;

  final isLoading = false.obs;

  Rx<File?> pickedImage = Rx<File?>(null);

  final imagePicker = ImagePicker();

  final AuthServices authServices = AuthServices();

  final ProfileController profileController = Get.find<ProfileController>();

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  // ----------------- Update Profile -----------------
  Future<void> updateProfile() async {
    try {
      isLoading.value = true;

      // Text values validation
      final fullName = fullNameController.text.trim();
      final phone = phoneController.text.trim();

      if (fullName.isEmpty || phone.isEmpty) {
        customSnackbar(
          title: "Error",
          message: "Full Name and Phone cannot be empty",
          isError: true,
        );
        return;
      }

      // Prepare data
      final data = {
        'full_name': fullName,
        'phone': phone,
      };

      File? file;
      if (pickedImage.value != null) {
        file = File(pickedImage.value!.path);
      }

      final response = await authServices.updateProfile(data, file);

      final responseData = jsonDecode(response.body);
      print(responseData);

      if (response.statusCode == 200) {
        profileController.loadUserData();
        Get.back();
        customSnackbar(
          title: "Success",
          message: responseData['message'],
        );
      } else {
        customSnackbar(
          title: "Error",
          message: responseData['message'] ?? 'Something went wrong',
          isError: true,
        );
      }
    } catch (e) {
      customSnackbar(
        title: "Error",
        message: e.toString(),
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ----------------- Load User Data -----------------
  void loadUserData() {

    if (Get.arguments != null && Get.arguments is UserData) {
      userData = Get.arguments as UserData;

      fullNameController = TextEditingController(text: userData.fullName ?? '');
      emailController = TextEditingController(text: userData.email ?? '');
      phoneController = TextEditingController(text: userData.phone ?? '');
      customerNameController =
          TextEditingController(text: userData.customerName ?? '');
      fullAddressController =
          TextEditingController(text: userData.fullAddress ?? '');
    } else {
      fullNameController = TextEditingController();
      emailController = TextEditingController();
      phoneController = TextEditingController();
      customerNameController = TextEditingController();
      fullAddressController = TextEditingController();
    }
  }

  // ----------------- Pick Image -----------------
  Future<void> pickImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage.value = File(pickedFile.path);
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    customerNameController.dispose();
    fullAddressController.dispose();
    super.onClose();
  }
}