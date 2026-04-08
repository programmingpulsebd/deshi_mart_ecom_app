import 'package:deshi_mart_ecom_app/app/data/common/widgets/custom_button.dart';
import 'package:deshi_mart_ecom_app/app/data/model/products.dart';
import 'package:deshi_mart_ecom_app/app/modules/products/productDetails/views/widgets/details.dart';
import 'package:deshi_mart_ecom_app/app/modules/products/productDetails/views/widgets/image_gallery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/model/cart_model.dart';
import '../../../shops/cart/controllers/cart_controller.dart';
import '../../../shops/favourite/controllers/favourite_controller.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  final Products? products;

  const ProductDetailsView({super.key, this.products});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final cartController = Get.put(CartController());
    final FavouriteController favController = Get.put(FavouriteController());

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Obx(() {
          final inCart = cartController.isInCart(products!.id!);
          return CustomButton(
            label: inCart ? "Added to Cart ✓" : "Add to Cart",
            onPressed: inCart
                ? null
                : () async {
                    await cartController.addToCart(
                      CartModel.fromProduct(products!),
                    );
                  },
          );
        }),
      ),

      appBar: AppBar(
        title: Text(products?.productName ?? ""),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),

              ImageGallery(products: products),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Details(
                  products: products,
                  theme: theme,
                  favController: favController,
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
