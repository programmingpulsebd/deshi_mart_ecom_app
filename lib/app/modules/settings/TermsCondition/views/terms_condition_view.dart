import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_config.dart';
import '../controllers/terms_condition_controller.dart';

class TermsConditionView extends GetView<TermsConditionController> {
  const TermsConditionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// App Info
            Text(
              AppConfig.appNAME,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              "Version ${AppConfig.appVERSION}",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 5),
            Text(
              "Developed by ${AppConfig.appAUTHOR}",
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            /// Terms Content
            Expanded(
              child: SingleChildScrollView(
                child: Text('''
Welcome to ${AppConfig.appNAME}!

By using this application, you agree to the following terms and conditions:

1. This app is developed for educational and commercial purposes.
2. Users must provide accurate information during usage.
3. We are not responsible for any loss or damage caused by misuse of the app.
4. All content and design are the property of ${AppConfig.appAUTHOR}.
5. We may update these terms at any time without prior notice.

If you have any questions, feel free to contact us.

Thank you for using ${AppConfig.appNAME} ❤️
''', style: const TextStyle(fontSize: 15, height: 1.5)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
