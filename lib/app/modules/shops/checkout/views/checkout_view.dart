import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/common/widgets/custom_button.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/themes/app_color.dart';
import '../controllers/checkout_controller.dart';
import '../../cart/controllers/cart_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("Delivery Address"),
            Obx(() => Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: controller.deliveryAddress.value.isEmpty ? Colors.red.shade200 : Colors.grey.shade200
                ),
              ),
              child: controller.deliveryAddress.value.isEmpty
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("No delivery address added yet!", style: TextStyle(color: Colors.red)),
                  IconButton(
                    onPressed: () {
                      Get.toNamed(
                          Routes.DELIVERY_ADDRESS,
                          arguments: controller.profileController.userData.value
                      );
                    },
                    icon: const Icon(Icons.edit_location_alt_outlined, color: AppColor.primary),
                    tooltip: "Add Address",
                  )
                ],
              )
                  : Row(
                children: [
                  const Icon(Icons.location_on_outlined, color: AppColor.primary),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(controller.deliveryAddress.value),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(
                          Routes.DELIVERY_ADDRESS,
                          arguments: controller.profileController.userData.value
                      );
                    },
                    child: const Text("Edit", style: TextStyle(color: AppColor.primary)),
                  )
                ],
              ),
            )),

            const SizedBox(height: 25),

            // 2. Payment Method Section
            _sectionTitle("Payment Method"),
            Obx(() => Column(
              children: [
                _paymentOption(
                  title: "Online Payment",
                  subtitle: "Pay via SSLCommerz (Bkash, Nagad, Card)",
                  icon: Icons.account_balance_wallet_outlined,
                  value: "online",
                  groupValue: controller.selectedPaymentMethod.value,
                  onChanged: (val) => controller.selectedPaymentMethod.value = val!,
                ),
                const SizedBox(height: 10),
                _paymentOption(
                  title: "Cash on Delivery",
                  subtitle: "Pay when you receive the product",
                  icon: Icons.delivery_dining_outlined,
                  value: "cod",
                  groupValue: controller.selectedPaymentMethod.value,
                  onChanged: (val) => controller.selectedPaymentMethod.value = val!,
                ),
              ],
            )),

            const SizedBox(height: 25),

            // 3. Order Summary Section
            _sectionTitle("Order Summary"),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _summaryRow("Items Total", "৳${cartController.totalPrice.toStringAsFixed(2)}"),
                  _summaryRow("Delivery Fee", "৳${cartController.deliveryCharge.toStringAsFixed(0)}"),
                  const Divider(),
                  _summaryRow("Total Payable", "৳${cartController.totalAmount.toStringAsFixed(2)}", isTotal: true),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Place Order Button
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: CustomButton(
          label: "Place Order",
          onPressed: () => controller.processOrder(),
        ),
      ),
    );
  }

  // Helper Widgets
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _paymentOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
    required String groupValue,
    required Function(String?) onChanged,
  }) {
    bool isSelected = value == groupValue;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primary.withValues(alpha: 0.05) : Theme.of(Get.context!).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? AppColor.primary : Colors.grey.shade200, width: 1.5),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? AppColor.primary : Colors.grey),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            Radio<String>(
              value: value,
              groupValue: groupValue,
              activeColor: AppColor.primary,
              onChanged: onChanged,
            )
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: isTotal ? 18 : 15, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(fontSize: isTotal ? 18 : 15, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal, color: isTotal ? AppColor.primary : Colors.grey)),
        ],
      ),
    );
  }
}