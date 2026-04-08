import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../../data/common/widgets/custom_button.dart';
import '../../../../../routes/app_pages.dart';
import '../../controllers/cart_controller.dart';

class CheckoutSheetContent extends StatelessWidget {
  const CheckoutSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.find<CartController>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Checkout", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.close)),
            ],
          ),
          const Divider(),

          Obx(() => Column(
            children: [
              _buildRow("Products Cost", "৳${controller.totalPrice.toStringAsFixed(2)}"),
              _buildRow("Delivery Charge", "৳${controller.deliveryCharge.toStringAsFixed(0)}"),
              _buildRow("Total Amount", "৳${controller.totalAmount.toStringAsFixed(2)}"),
            ],
          )),

          const SizedBox(height: 25),

          CustomButton(
              label: 'Confirm Order',
              onPressed: () {
                Get.back();
                Get.toNamed(Routes.CHECKOUT);
              }
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey)),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}