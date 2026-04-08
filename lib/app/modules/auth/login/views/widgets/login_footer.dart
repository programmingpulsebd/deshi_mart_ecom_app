import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../../../routes/app_pages.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Don’t have an account?"),
          TextButton(
            onPressed: () {
              Get.toNamed(Routes.REGISTER);
            },
            child: Text("Sign Up"),
          ),
        ],
      ),
    );
  }
}
