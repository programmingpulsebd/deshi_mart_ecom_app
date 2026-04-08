import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/helper/contact_helper.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/help_support_controller.dart';

class HelpSupportView extends GetView<HelpSupportController> {
  const HelpSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Get.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// Intro Text
          Text(
            "How can we help you?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),

          const SizedBox(height: 15),

          /// FAQ Tile
          _buildTile(
            icon: Icons.question_answer,
            title: "FAQs",
            subtitle: "Find answers to common questions",
            isDark: isDark,
            onTap: () {
            },
          ),

          /// Contact Tile
          _buildTile(
            icon: Icons.email,
            title: "Contact Us",
            subtitle: "Reach out via email",
            isDark: isDark,
            onTap: () {
              ContactHelper.makeCall("+8801746428299");
            },
          ),
          /// Call Support
          _buildTile(
            icon: Icons.call,
            title: "Call Support",
            subtitle: "Talk to our support team",
            isDark: isDark,
            onTap: () {
              ContactHelper.makeCall("+8801746428299");
            },
          ),

          /// About App
          _buildTile(
            icon: Icons.info,
            title: "About App",
            subtitle: "Learn more about the app",
            isDark: isDark,
            onTap: () {
              Get.toNamed(Routes.ABOUT);

            },
          ),
        ],
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: Colors.green),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}