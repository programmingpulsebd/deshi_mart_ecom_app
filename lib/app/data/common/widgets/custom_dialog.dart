import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogUtils {
  /// Generic Confirm Dialog
  /// All parameters customizable: title, message, icon, button texts, confirm action
  static void showConfirmDialog({
    String title = 'Confirm',
    String message = 'Are you sure?',
    IconData icon = Icons.help_outline,
    Color iconColor = Colors.deepPurple,
    String cancelText = 'Cancel',
    String confirmText = 'OK',
    VoidCallback? onConfirm,
  }) {
    final isDark = Get.isDarkMode;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: iconColor.withValues(alpha: 0.1),
                child: Icon(icon, color: iconColor, size: 30),
              ),

              const SizedBox(height: 15),

              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 20),

              // Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Cancel Button
                  OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade400),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 25),
                    ),
                    child: Text(
                      cancelText,
                      style: TextStyle(
                          color: isDark ? Colors.grey.shade300 : Colors.black),
                    ),
                  ),

                  // Confirm Button
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                      if (onConfirm != null) onConfirm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: iconColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 25),
                    ),
                    child: Text(
                      confirmText,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}