import 'package:deshi_mart_ecom_app/app/modules/products/productDetails/views/widgets/related_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../data/model/fav_model.dart';
import '../../../../../data/model/products.dart';
import '../../../../../utils/themes/app_color.dart';
import '../../../../shops/favourite/controllers/favourite_controller.dart';

class Details extends StatelessWidget {
  const Details({
    super.key,
    required this.products,
    required this.theme,
    required this.favController,
  });

  final Products? products;
  final ThemeData theme;
  final FavouriteController favController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                products?.productName ?? "",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Obx(() {
              final isFav = favController.isFav(products!.id!);
              return GestureDetector(
                onTap: () async => await favController.toggleFav(
                  FavouriteModel.fromProduct(products!),
                ),
                child: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : Colors.grey[600],
                ),
              );
            }),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          '1kg Price  ৳${products?.offerPrice}',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${products?.categoryName}",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColor.primary,
              ),
            ),

            Text(
              "৳${products?.offerPrice}",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),

        Text("Product Details", style: theme.textTheme.titleMedium),
        const SizedBox(height: 10),

        Text(
          products?.description ?? "",
          style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
        ),

        const SizedBox(height: 30),

        Text(
          "Related Products",
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 10),

        RelatedProduct(products: products),
      ],
    );
  }
}
