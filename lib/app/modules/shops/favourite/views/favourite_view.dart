import 'package:deshi_mart_ecom_app/app/modules/shops/favourite/views/widgets/fav_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../cart/controllers/cart_controller.dart';
import '../controllers/favourite_controller.dart';

class FavouriteView extends GetView<FavouriteController> {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cartController = Get.put(CartController());
    final controller = Get.put(FavouriteController());

    return Scaffold(
      appBar: AppBar(title: const Text('My Favourite')),
      body: Obx(() {
        if (controller.favItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.favorite_border, size: 80, color: Colors.grey[300]),
                const SizedBox(height: 16),
                Text(
                  "No favourites added yet!",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 15),
          itemCount: controller.favItems.length,
          separatorBuilder: (_, _) => Divider(
            color: theme.dividerColor,
            thickness: 0.5,
            indent: 20,
            endIndent: 20,
          ),
          itemBuilder: (context, index) {
            final item = controller.favItems[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: FavItem(
                theme: theme,
                item: item,
                cartController: cartController,
                controller: controller,
              ),
            );
          },
        );
      }),
    );
  }
}
