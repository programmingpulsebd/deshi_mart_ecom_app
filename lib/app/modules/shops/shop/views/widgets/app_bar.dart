import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_config.dart';
import '../../../../../utils/app_images.dart';
import '../../../../settings/theme/controllers/theme_controller.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());

    return SizedBox(
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Text(
              AppConfig.appNAME,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              AppImages.mainLogo,
              height: 35,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Obx(() => InkWell(
              onTap: () {
                themeController.toggleTheme();
              },
              child: Icon(
                themeController.isDarkMode.value
                    ? Icons.dark_mode
                    : Icons.light_mode,
                size: 28,
              ),
            )),
          ),
        ],
      ),
    );
  }
}