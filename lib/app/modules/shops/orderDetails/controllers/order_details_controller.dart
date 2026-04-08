import 'package:get/get.dart';
import '../../../../data/model/orders.dart'; // আপনার মডেল পাথ

class OrderDetailsController extends GetxController {
  late Data order;

  @override
  void onInit() {
    super.onInit();
    // arguments থেকে অর্ডারের ডাটা নেওয়া হচ্ছে
    order = Get.arguments;
  }
}