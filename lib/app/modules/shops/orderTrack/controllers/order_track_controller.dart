import 'dart:convert';
import 'package:deshi_mart_ecom_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import '../../../../data/model/orders.dart';
import '../../../../data/services/order_services.dart';

class OrderTrackController extends GetxController {

  var isLoading = false.obs;
  var orderList = <Data>[].obs;
  var errorMessage = ''.obs;

  final OrderServices orderServices = OrderServices();


  @override
  void onInit() {
    super.onInit();
    // স্ক্রিন ওপেন হওয়ার সাথে সাথে ডিফল্টভাবে 'pending' ডাটা লোড হবে
    fetchOrdersByStatus('pending');
  }

  // ডাটা ফেচ করার ফাংশন
  Future<void> fetchOrdersByStatus(String status) async {
    try {
      isLoading(true);
      errorMessage('');

      // তোমার সার্ভিস ফাংশন কল করা হচ্ছে
      final response = await orderServices.getOrdersByStatus(status);

      if (response.statusCode == 200) {

        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['status'] == 'success') {
          final List<dynamic> rawData = responseData['data'];
          orderList.value = rawData.map((json) => Data.fromJson(json)).toList();
        } else {
          errorMessage.value = "ডাটা পাওয়া যায়নি";
        }
      } else {
        errorMessage.value = "সার্ভার এরর: ${response.statusCode}";
        Get.snackbar("Error", "ডাটা লোড করতে সমস্যা হয়েছে");
      }
    } catch (e) {
      errorMessage.value = "কানেকশন এরর: $e";
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }

  // স্ট্যাটাস ফিল্টার চেঞ্জ করার জন্য ফাংশন (UI থেকে কল করবে)
  void changeStatus(String newStatus) {
    fetchOrdersByStatus(newStatus);
  }

  void goToOrderDetails(Data order) {
       Get.toNamed(Routes.ORDER_DETAILS, arguments: order);
  }
}