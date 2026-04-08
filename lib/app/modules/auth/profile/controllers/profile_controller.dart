import 'dart:convert';
import 'package:get/get.dart';
import '../../../../data/auth_services/auth_session.dart';
import '../../../../data/common/widgets/custom_snackbar.dart';
import '../../../../data/model/user_model.dart';
import '../../../../data/services/account_service.dart';
import '../../../../data/services/auth_services.dart';
import '../../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final AuthSession authSession = AuthSession();
  final AuthServices authServices = AuthServices();
  final AccountService accountService = AccountService();


  final RxnBool isLoggedIn = RxnBool();
  final isLoading = false.obs;
  final userData = UserData().obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    try {
      isLoading.value = true;

      final loggedIn = await authSession.checkLogin();
      isLoggedIn.value = loggedIn;

      if (loggedIn) {
        final response = await authServices.profile();
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          userData.value = UserData.fromJson(data["data"]);
        } else {
          isLoggedIn.value = false;
        }
      }
    } catch (e) {
      isLoggedIn.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await authSession.userLogOut();
    isLoggedIn.value = false;
    Get.offAllNamed(Routes.LOGIN);
  }


  Future<void> deleteAccount() async {
    try {
      isLoading.value = true;

      final response = await accountService.deleteAccount();

      if (response.statusCode == 200) {
        await authSession.userLogOut();
        isLoggedIn.value = false;
        Get.offAllNamed(Routes.LOGIN);
      } else {
        final data = jsonDecode(response.body);
        customSnackbar(
          title: "Error",
          message: data["message"] ?? "Something went wrong",
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