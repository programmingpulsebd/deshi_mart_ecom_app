import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';

class ThemeView extends GetView<ThemeController> {
  const ThemeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        children: [
          Obx(() => ListTile(
            leading: Icon(
              controller.isDarkMode.value ? Icons.dark_mode : Icons.light_mode,
              color: controller.isDarkMode.value ? Colors.amber : Colors.blue,
            ),
            title: const Text(
              'Dark Mode',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              controller.isDarkMode.value ? "Switch to Light Mode" : "Switch to Dark Mode",
            ),
            trailing: Switch(
              value: controller.isDarkMode.value,
              onChanged: (value) {
                controller.toggleTheme();
              },
            ),
            onTap: () => controller.toggleTheme(),
          )),

        ],
      ),
    );
  }
}