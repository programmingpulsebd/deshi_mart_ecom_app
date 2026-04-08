import 'package:deshi_mart_ecom_app/app/modules/products/product/views/widgets/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/api_url/api_url.dart';
import '../../../shops/shop/controllers/shop_controller.dart';
import '../controllers/product_controller.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final ShopController controller = Get.put(ShopController());

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.selectedCategoryName.value.isEmpty
                ? "Products"
                : controller.selectedCategoryName.value,
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
        child: Obx(() {
          if (controller.isProductLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.products.isEmpty) {
            return const Center(child: Text("No Products Found"));
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              final product = controller.products[index];

              return ProductGridCard(
                product: product,
                onTap: () =>
                    Get.toNamed(Routes.PRODUCT_DETAILS, arguments: product),
              );
            },
          );
        }),
      ),
    );
  }
}
