import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_config.dart';
import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Get.isDarkMode;

    return Scaffold(
      appBar: AppBar(title: const Text('About App'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.green,
                child: Text(
                  AppConfig.appNAME[0],
                  style: const TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Center(
              child: Text(
                AppConfig.appNAME,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 5),

            Center(
              child: Text(
                "Version: ${AppConfig.appVERSION}",
                style: TextStyle(
                  color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                ),
              ),
            ),
            Center(
              child: Text(
                "Author: ${AppConfig.appAUTHOR}",
                style: TextStyle(
                  color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                ),
              ),
            ),

            const SizedBox(height: 25),

            /// About Description
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  '''
Welcome to ${AppConfig.appNAME}!

${AppConfig.appNAME} is designed and developed by ${AppConfig.appAUTHOR}. Our mission is to provide high-quality, user-friendly experience for our customers.

Features of the app:
- Easy to use interface
- Fast and responsive
- Theme-friendly (Dark / Light mode)
- Regular updates and support

We hope you enjoy using ${AppConfig.appNAME}!
''',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
