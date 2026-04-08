import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../../data/common/widgets/custom_loading.dart';
import '../../../../../data/model/cart_model.dart';
import '../../../../../data/model/fav_model.dart';
import '../../../../../utils/api_url/api_url.dart';
import '../../../../../utils/themes/app_color.dart';
import '../../../cart/controllers/cart_controller.dart';
import '../../controllers/favourite_controller.dart';

class FavItem extends StatelessWidget {
  const FavItem({
    super.key,
    required this.theme,
    required this.item,
    required this.cartController,
    required this.controller,
  });

  final ThemeData theme;
  final FavouriteModel item;
  final CartController cartController;
  final FavouriteController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
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
        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.productName,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              if (item.categoryName != null)
                Text(
                  item.categoryName!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text(
                    '৳${item.effectivePrice}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColor.primary,
                    ),
                  ),
                  if (item.offerPrice != null) ...[
                    const SizedBox(width: 6),
                    Text(
                      '৳${item.price}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),

        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() {
              final inCart = cartController.isInCart(item.id);
              return InkWell(
                onTap: inCart
                    ? null
                    : () async => await cartController.addToCart(
                  CartModel(
                    id: item.id,
                    productName: item.productName,
                    productImage: item.productImage,
                    price: item.price,
                    offerPrice: item.offerPrice,
                    categoryName: item.categoryName,
                    stock: item.stock,
                  ),
                ),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: inCart
                        ? Colors.green.withValues(alpha: 0.15)
                        : AppColor.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    inCart ? Icons.check : Icons.add_shopping_cart,
                    color: inCart ? Colors.green : AppColor.primary,
                    size: 20,
                  ),
                ),
              );
            }),
            const SizedBox(height: 8),
            InkWell(
              onTap: () => controller.removeFromFav(item.id),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.delete, color: Colors.red, size: 20),
              ),
            ),
          ],
        ),
      ],
    );
  }
}