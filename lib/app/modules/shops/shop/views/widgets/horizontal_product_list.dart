import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../utils/api_url/api_url.dart';
import '../../controllers/shop_controller.dart';
import '../shimmer/latest_product_shimmer.dart';
import 'latest_product_card.dart';

class HorizontalProductList extends StatelessWidget {
  const HorizontalProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ShopController());

    return SizedBox(
      height: 220,
      child: Obx(() {
        if (controller.isLatestProductLoading.value) {
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            separatorBuilder: (_, __) => const SizedBox(width: 15),
            itemBuilder: (_, __) => const LatestProductCardShimmer(),
          );
        }

        if (controller.latestProducts.isEmpty) {
          return const Center(child: Text("No Products Found"));
        }

        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.latestProducts.length,
          separatorBuilder: (_, __) => const SizedBox(width: 15),
          itemBuilder: (_, index) {
            final product = controller.latestProducts[index];
            return LatestProductCard(
              product: product,
              onTap: () => Get.toNamed(Routes.PRODUCT_DETAILS, arguments: product),
            );
          },
        );
      }),
    );
  }
}