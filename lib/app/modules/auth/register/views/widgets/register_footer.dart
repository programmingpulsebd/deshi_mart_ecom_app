import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../../../routes/app_pages.dart';

class RegisterFooter extends StatelessWidget {
  const RegisterFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Already have an account?"),
          TextButton(onPressed: () {
            Get.toNamed(Routes.LOGIN);
          }, child: Text("Log In")),
        ],
      ),
    );
  }
}