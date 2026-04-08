import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/common/widgets/custom_loading.dart';
import '../../../../../data/model/cart_model.dart';
import '../../../../../data/model/fav_model.dart';
import '../../../../../data/model/products.dart';
import '../../../../../utils/api_url/api_url.dart';
import '../../../../../utils/themes/app_color.dart';
import '../../../../shops/cart/controllers/cart_controller.dart';
import '../../../../shops/favourite/controllers/favourite_controller.dart';

class ProductGridCard extends StatelessWidget {
  final Products product;
  final VoidCallback? onTap;

  const ProductGridCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cartController = Get.put(CartController());
    final favController = Get.put(FavouriteController());

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: theme.colorScheme.primary.withValues(alpha: 0.05),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        '${ApiUrl.imgBase}${product.productImage}',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const Center(
                            child: CustomLoading(size: 30, color: AppColor.primary),
                          );
                        },
                        errorBuilder: (_, __, ___) => Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey[400],
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Price + offer price
                      Row(
                        children: [
                          Text(
                            '৳${product.offerPrice ?? product.price ?? 0}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColor.primary,
                            ),
                          ),
                          if (product.offerPrice != null) ...[
                            const SizedBox(width: 6),
                            Text(
                              '৳${product.price}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ],
                      ),

                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Stock: ${product.stock ?? 0}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                            ),
                          ),

                          // ── Add to Cart ──────────
                          Obx(() {
                            final inCart = cartController.isInCart(product.id!);
                            return GestureDetector(
                              onTap: inCart
                                  ? null
                                  : () async => await cartController.addToCart(
                                CartModel.fromProduct(product),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: inCart ? Colors.green : theme.colorScheme.primary,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  inCart ? Icons.check : Icons.add,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // ── Favourite Button ─────────────────
            Positioned(
              top: 12,
              right: 12,
              child: Obx(() {
                final isFav = favController.isFav(product.id!);
                return GestureDetector(
                  onTap: () async => await favController.toggleFav(
                    FavouriteModel.fromProduct(product),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : theme.colorScheme.primary,
                      size: 20,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}