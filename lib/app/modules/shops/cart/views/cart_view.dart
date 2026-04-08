import 'package:deshi_mart_ecom_app/app/data/common/widgets/custom_loading.dart';
import 'package:deshi_mart_ecom_app/app/modules/shops/cart/views/widgets/bottom_check_out.dart';
import 'package:deshi_mart_ecom_app/app/modules/shops/cart/views/widgets/empty_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/api_url/api_url.dart';
import '../../../../utils/themes/app_color.dart';
import '../controllers/cart_controller.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final CartController controller = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),

      ),

      bottomNavigationBar: Obx(() {
        if (controller.cartItems.isEmpty) return const SizedBox();
        return BottomCheckOut(theme: theme, controller: controller);
      }),

      body: Obx(() {

        if (controller.cartItems.isEmpty) {
          return Center(
            child: EmptyCart(theme: theme),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemCount: controller.cartItems.length,
          separatorBuilder: (_, __) => Divider(
            color: theme.dividerColor,
            thickness: 0.5,
            indent: 20,
            endIndent: 20,
          ),
          itemBuilder: (context, index) {
            final item = controller.cartItems[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        '${ApiUrl.imgBase}${item.productImage}',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Icon(Icons.image_not_supported, color: Colors.grey[400]),
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return Center(
                            child: CustomLoading(size: 20, color: AppColor.primary),
                          );
                        },


                      ),
                    ),
                  ),
                  const SizedBox(width: 20),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item.productName,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => controller.removeFromCart(item.id),
                              child: Icon(Icons.close, color: Colors.grey.shade400, size: 22),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),

                        if (item.categoryName != null)
                          Text(
                            item.categoryName!,
                            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                          ),
                        const SizedBox(height: 12),

                        Row(
                          children: [
                            // Decrease
                            GestureDetector(
                              onTap: () => controller.decreaseQty(item.id),
                              child: _qtyActionBtn(
                                Icons.remove,
                                theme.dividerColor.withValues(alpha: 0.2),
                                Colors.grey,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                '${item.quantity}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            // Increase
                            GestureDetector(
                              onTap: () => controller.increaseQty(item.id),
                              child: _qtyActionBtn(
                                Icons.add,
                                AppColor.primary,
                                Colors.white,
                                hasBorder: true,
                              ),
                            ),
                            const Spacer(),

                            // Price (offer price strikethrough যদি থাকে)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '৳${(item.effectivePrice * item.quantity)}',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.primary,
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  Widget _qtyActionBtn(IconData icon, Color bgColor, Color iconColor, {bool hasBorder = false}) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: hasBorder ? Border.all(color: Colors.grey.shade200) : null,
        color: bgColor,
      ),
      child: Icon(icon, color: iconColor, size: 20),
    );
  }


}



