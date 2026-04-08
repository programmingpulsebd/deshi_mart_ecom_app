import 'package:deshi_mart_ecom_app/app/modules/shops/shop/views/shimmer/latest_product_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../../data/model/products.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../utils/api_url/api_url.dart';
import '../../../../shops/shop/views/widgets/latest_product_card.dart';
import '../../controllers/product_details_controller.dart';
import '../product_details_view.dart';

class RelatedProduct extends StatefulWidget {
  final Products? products;

  const RelatedProduct({super.key, this.products});

  @override
  State<RelatedProduct> createState() => _RelatedProductState();
}

class _RelatedProductState extends State<RelatedProduct> {
  final controller = Get.put(ProductDetailsController());

  @override
  void initState() {
    super.initState();
    controller.relatedProducts(widget.products!.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Obx(() {
        if (controller.isProductLoading.value) {
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            separatorBuilder: (_, __) => const SizedBox(width: 15),
            itemBuilder: (_, __) => const LatestProductCardShimmer(),
          );
        }
        if (controller.products.isEmpty) {
          return Center(child: Text("No Related Product Found"));
        }

        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.products.length,
          separatorBuilder: (_, _) => const SizedBox(width: 15),
          itemBuilder: (_, index) {

            final product = controller.products[index];

            return LatestProductCard(
              product: product,
              onTap: () => Get.toNamed(Routes.PRODUCT_DETAILS, arguments: product),
            );          },
        );
      }),
    );
  }
}
