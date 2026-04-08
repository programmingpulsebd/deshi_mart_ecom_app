import 'package:get/get.dart';

import '../../../data/auth_services/auth_session.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {


  @override
  void onInit() {
    checkAuth();
    super.onInit();
  }

  Future<void> checkAuth() async{

    final authSession = AuthSession();
    final login = await authSession.checkLogin();


    Future.delayed(Duration (seconds: 3) ,() {
      Get.offAllNamed(Routes.HOME);
    });

  }


}
