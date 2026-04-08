import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/common/widgets/custom_snackbar.dart';
import '../../../../data/model/cart_model.dart';
import '../../../../data/services/bkash_payment_service.dart';
import '../../../../data/services/order_services.dart';
import '../../../../routes/app_pages.dart';
import '../../../auth/deliveryAddress/views/widgets/address_dialog.dart';
import '../../../auth/profile/controllers/profile_controller.dart';
import '../../cart/controllers/cart_controller.dart';

class CheckoutController extends GetxController {
  var selectedPaymentMethod = "online".obs;
  var deliveryAddress = "".obs;

  final profileController = Get.put(ProfileController());
  final OrderServices orderServices = OrderServices();

  final CartController cartController = Get.find<CartController>();
  var cartItems = <CartModel>[].obs;


  final BkashPaymentService bkashService = BkashPaymentService();

  @override
  void onInit() {
    super.onInit();
    loadUserAddress();

    ever(profileController.userData, (_) {
      loadUserAddress();
    });

    cartItems.assignAll(cartController.cartItems);
    ever(cartController.cartItems, (_) {
      cartItems.assignAll(cartController.cartItems);
    });
  }

  void loadUserAddress() {
    final user = profileController.userData.value;
    if (user.fullAddress != null && user.fullAddress!.isNotEmpty) {
      deliveryAddress.value =
          "${user.fullAddress}, ${user.upazila}, ${user.district}";
    }
  }

  int get totalAmount => cartItems.fold(
    0,
    (sum, item) => sum + (item.effectivePrice * item.quantity),
  );

  int get deliveryCharge => cartItems.isEmpty ? 0 : 100;

  int get totalAmountWithDelivery => totalAmount + deliveryCharge;

  List<Map<String, dynamic>> get orderItems => cartItems.map((item) {
    return {
      "product_id": item.id,
      "quantity": item.quantity,
      "price": item.effectivePrice,
    };
  }).toList();

  void processOrder() async {

    if (deliveryAddress.value.isEmpty) {
      Get.dialog(
        AddressRequiredDialog(
          onAddAddress: () {
            Get.back();
            Get.toNamed(
              Routes.DELIVERY_ADDRESS,
              arguments: profileController.userData.value,
            );
          },
        ),
        barrierDismissible: false,
      );
      return;
    }

    if (cartItems.isEmpty) {
      Get.snackbar("Cart Empty", "Please add some products before ordering");
      return;
    }

    try {

      if (selectedPaymentMethod.value == "online") {
        // 🔥 ONLINE PAYMENT FIRST
        Get.dialog(
          const Center(child: CircularProgressIndicator()),
          barrierDismissible: false,
        );

        final paymentResponse = await bkashService.payWithBkash(
          amount: totalAmountWithDelivery.toDouble(),
          invoice: "INV-${DateTime.now().millisecondsSinceEpoch}",
        );

        Get.back(); // close loader

        print("Payment Success: $paymentResponse");

        // ✅ Payment successful -> now create order
        Get.dialog(
          const Center(child: CircularProgressIndicator()),
          barrierDismissible: false,
        );

        final orderBody = {
          "user_id": profileController.userData.value.id,
          "order_items": cartItems
              .map((item) => {
            "product_id": item.id,
            "quantity": item.quantity,
            "price": item.effectivePrice,
          })
              .toList(),
          "delivery_address": {"address": deliveryAddress.value},
          "total_amount": totalAmountWithDelivery,
          "payment_method": "online",
        };

        final response = await orderServices.placeOrder(body: orderBody);

        Get.back(); // close loader

        if (response["success"] == true) {
          cartController.cartItems.clear();
          customSnackbar(
            title: 'Payment & Order Success',
            message: 'Your order has been placed successfully!',
          );
          Get.offAllNamed(Routes.ORDER_SUCCESS);
          cartController.clearCart();

        } else {
          Get.snackbar(
            "Order Failed",
            response["message"] ?? "Failed to place order",
          );
        }
      }
      else {
        // 🔥 CASH ON DELIVERY
        Get.dialog(
          const Center(child: CircularProgressIndicator()),
          barrierDismissible: false,
        );

        final orderBody = {
          "user_id": profileController.userData.value.id,
          "order_items": cartItems
              .map((item) => {
            "product_id": item.id,
            "quantity": item.quantity,
            "price": item.effectivePrice,
          })
              .toList(),
          "delivery_address": {"address": deliveryAddress.value},
          "total_amount": totalAmountWithDelivery,
          "payment_method": "cod",
        };

        final response = await orderServices.placeOrder(body: orderBody);

        Get.back(); // close loader

        if (response["success"] == true) {
          cartController.cartItems.clear();
          customSnackbar(
            title: 'Order Success',
            message: 'Order placed with Cash on Delivery!',
          );
          Get.offAllNamed(Routes.ORDER_SUCCESS);
          cartController.clearCart();

        } else {
          Get.snackbar(
            "Order Failed",
            response["message"] ?? "Failed to place order",
          );
        }
      }
    } catch (e) {
      Get.back();
      Get.snackbar("Error", e.toString());
    }
  }







}



