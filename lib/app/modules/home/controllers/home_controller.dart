import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }


  Future<bool> handleWillPop(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,

      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(10),
        ),
        title: const Text("Exit App"),
        content: const Text("Are you sure you want to exit?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Yes"),
          ),
        ],
      ),
    );
    return result ?? false;
  }



}
