import 'package:deshi_mart_ecom_app/app/utils/app_config.dart';
import 'package:deshi_mart_ecom_app/app/utils/app_images.dart';
import 'package:deshi_mart_ecom_app/app/utils/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // <--- Ei import-ta add korun
import 'package:get/get.dart';
import '../../../data/common/widgets/custom_loading.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: AppColor.primary,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColor.primary, AppColor.primaryLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: const Duration(seconds: 2),
                  builder: (context, double value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.scale(scale: value, child: child),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        AppImages.logo,
                        fit: BoxFit.contain,
                        height: 150,
                        width: 150,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        AppConfig.appNAME,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: CustomLoading(size: 50, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}