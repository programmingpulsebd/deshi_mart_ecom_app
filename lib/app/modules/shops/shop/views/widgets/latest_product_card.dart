import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/common/widgets/custom_loading.dart';
import '../../../../../data/model/cart_model.dart';
import '../../../../../data/model/products.dart';
import '../../../../../utils/api_url/api_url.dart';
import '../../../../../utils/themes/app_color.dart';
import '../../../cart/controllers/cart_controller.dart';

class LatestProductCard extends StatelessWidget {
  const LatestProductCard({
    super.key,
    required this.product, // Product object directly নাও
    this.onTap,
  });

  final Products product;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cartController = Get.put(CartController());

    return InkWell(
      onTap: onTap,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: theme.dividerColor.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 110,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "${ApiUrl.imgBase}${product.productImage}",
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Icon(Icons.image, size: 60, color: Colors.grey[400]),
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Center(
                      child: CustomLoading(size: 40, color: AppColor.primary),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Product Name
            Text(
              product.productName ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 2),

            Text(
              'Stock: ${product.stock ?? 0}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.6),
              ),
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '৳${product.offerPrice ?? product.price ?? 0}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Obx(() {
                  final inCart = cartController.isInCart(product.id!);
                  return InkWell(
                    onTap: inCart
                        ? null
                        : () async => await cartController.addToCart(
                      CartModel.fromProduct(product),
                    ),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: inCart ? Colors.green : AppColor.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        inCart ? Icons.check : Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}