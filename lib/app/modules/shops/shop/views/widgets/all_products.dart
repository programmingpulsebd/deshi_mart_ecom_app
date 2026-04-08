import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../routes/app_pages.dart';
import '../../../../products/product/views/widgets/product_grid.dart';
import '../../controllers/shop_controller.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ShopController());

    return Obx(() {
      if (controller.isAllProductLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      if (controller.allProducts.isEmpty) {
        return Center(child: Text("No Products Found"));
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          final product = controller.allProducts[index];



          return ProductGridCard(
            product: product,
            onTap: () => Get.toNamed(Routes.PRODUCT_DETAILS, arguments: product),
          ) ;        },
      );
    });
  }
}
