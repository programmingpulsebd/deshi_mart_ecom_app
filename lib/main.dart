import 'package:deshi_mart_ecom_app/app/utils/app_config.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/utils/themes/app_themes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConfig.appNAME,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,

      builder: (context, child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        AppThemes.setSystemBars(isDark: isDark);
        return child!;
      },


    ),
  );
}
