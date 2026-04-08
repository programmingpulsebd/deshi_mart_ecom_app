import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/auth_services/auth_session.dart';
import '../../../../data/common/widgets/custom_snackbar.dart';
import '../../../../data/model/cart_model.dart';
import '../../../../routes/app_pages.dart';
import '../views/widgets/check_out_bottom_sheet.dart';

class CartController extends GetxController {
  final RxList<CartModel> cartItems = <CartModel>[].obs;
  static const cartKey = 'cart_items';
  final AuthSession authSession = AuthSession();

  @override
  void onInit() {
    super.onInit();
    loadCart(); // app start-এ storage থেকে load
  }

  // ── Load ─────────────────────────────────────
  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(cartKey);
    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      cartItems.assignAll(
        decoded
            .map((e) => CartModel.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
      );
    }
  }

  // ── Save ─────────────────────────────────────
  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(cartItems.map((e) => e.toJson()).toList());
    await prefs.setString(cartKey, jsonString);
  }

  // ── Add ──────────────────────────────────────
  Future<void> addToCart(CartModel cartItem) async {
    final login = await authSession.checkLogin();
    if (!login) {
      Get.toNamed(Routes.LOGIN);
      return;
    }

    final index = cartItems.indexWhere((item) => item.id == cartItem.id);
    if (index != -1) {
      // stock check
      if (cartItem.stock != null && cartItems[index].quantity >= cartItem.stock!) {
        customSnackbar(
          title: "Stock Limit",
          message: "No more stock available",
          isError: true,
        );
        return;
      }
      cartItems[index].quantity++;
      cartItems.refresh();
    } else {
      cartItems.add(cartItem);
    }

    await saveCart();
    customSnackbar(
      title: "Success",
      message: "${cartItem.productName} added to cart",
      isError: false,
    );
  }

  // ── Remove ───────────────────────────────────
  Future<void> removeFromCart(int id) async {
    cartItems.removeWhere((item) => item.id == id);
    await saveCart();
  }

  // ── Increase ─────────────────────────────────
  Future<void> increaseQty(int id) async {
    final index = cartItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      final item = cartItems[index];
      if (item.stock != null && item.quantity >= item.stock!) {
        customSnackbar(
          title: "Stock Limit",
          message: "No more stock available",
          isError: true,
        );
        return;
      }
      cartItems[index].quantity++;
      cartItems.refresh();
      await saveCart();
    }
  }

  // ── Decrease ─────────────────────────────────
  Future<void> decreaseQty(int id) async {
    final index = cartItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
        cartItems.refresh();
      } else {
        cartItems.removeAt(index);
      }
      await saveCart();
    }
  }

  // ── Clear ────────────────────────────────────
  Future<void> clearCart() async {
    cartItems.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(cartKey);
  }

  // ── Getters ──────────────────────────────────
  bool isInCart(int id) => cartItems.any((item) => item.id == id);
  int get totalItems => cartItems.fold(0, (sum, e) => sum + e.quantity);
  double get totalPrice =>
      cartItems.fold(0.0, (sum, e) => sum + (e.effectivePrice * e.quantity));





  double get deliveryCharge => cartItems.isEmpty ? 0.0 : 100.0;

  double get totalAmount => totalPrice + deliveryCharge;

  void openCheckout() {
    if (cartItems.isEmpty) {
      customSnackbar(title: "Empty", message: "Your cart is empty", isError: true);
      return;
    }

    Get.bottomSheet(
      const CheckoutSheetContent(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }















}

