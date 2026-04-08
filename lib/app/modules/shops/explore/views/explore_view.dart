import 'package:deshi_mart_ecom_app/app/data/common/widgets/custom_loading.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../data/common/widgets/search_bar.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/themes/app_color.dart';
import '../../../products/product/views/widgets/product_grid.dart';
import '../../shop/views/shop_view.dart';
import '../controllers/explore_controller.dart';

class ExploreView extends GetView<ExploreController> {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExploreController());
    return Scaffold(
      appBar: AppBar(title: const Text('Find Products')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            CustomSearchBar(
              onChanged: (query) => controller.filterProducts(query),
              hintText: "Search Products",
            )
            ,

            SizedBox(height: 10),

            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => await controller.fetchProducts(),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CustomLoading(
                      size: 40,
                      color: AppColor.primary,
                    ));
                  }
                  if (controller.products.isEmpty) {
                    return Center(child: Text("No Products Found"));
                  }

                  return  GridView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: controller.filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = controller.filteredProducts[index];
                      return ProductGridCard(
                        product: product,
                        onTap: () => Get.toNamed(Routes.PRODUCT_DETAILS, arguments: product),
                      ) ;

                    },
                  );


                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
