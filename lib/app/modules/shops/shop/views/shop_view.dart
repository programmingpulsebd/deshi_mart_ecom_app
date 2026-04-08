import 'package:deshi_mart_ecom_app/app/modules/shops/shop/views/widgets/all_products.dart';
import 'package:deshi_mart_ecom_app/app/modules/shops/shop/views/widgets/app_bar.dart';
import 'package:deshi_mart_ecom_app/app/modules/shops/shop/views/widgets/banner_slider.dart';
import 'package:deshi_mart_ecom_app/app/modules/shops/shop/views/widgets/category_list.dart';
import 'package:deshi_mart_ecom_app/app/modules/shops/shop/views/widgets/horizontal_product_list.dart';
import 'package:deshi_mart_ecom_app/app/modules/shops/shop/views/widgets/section_header.dart';
import 'package:deshi_mart_ecom_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/common/widgets/search_bar.dart';
import '../controllers/shop_controller.dart';

class ShopView extends GetView<ShopController> {
  const ShopView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ShopController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              const SizedBox(height: 10),

              HomeAppBar(context: context),
              const SizedBox(height: 10),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomSearchBar(
                        hintText: "Search Category",
                        onChanged: (value) {
                          controller.applySearch(value);
                        },
                      ),
                      const SizedBox(height: 10),

                      Text(
                        "Category",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      CategoryList(),

                      BannerSlider(controller: controller),

                       SectionHeader(title: 'Latest Products'),
                      HorizontalProductList(),

                       SectionHeader(title: 'All Products',
                            text: "See all",
                          onTap: () {
                            Get.toNamed(Routes.SHOP + Routes.EXPLORE);
                }
                      ),
                      AllProducts(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
