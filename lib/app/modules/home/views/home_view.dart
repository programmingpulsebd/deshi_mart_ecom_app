import 'package:deshi_mart_ecom_app/app/modules/shops/shop/views/shop_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/themes/app_color.dart';
import '../../auth/profile/views/profile_view.dart';
import '../../shops/cart/views/cart_view.dart';
import '../../shops/explore/views/explore_view.dart';
import '../../shops/favourite/views/favourite_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final List<Widget> page = [
    ShopView(),
    ExploreView(),
    CartView(),
    FavouriteView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return controller.handleWillPop(context);
      },
      child: Scaffold(
        body: Obx(() => page[controller.selectedIndex.value]),

        bottomNavigationBar: Obx(
          () => NavigationBarTheme(
            data: NavigationBarThemeData(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              indicatorColor: AppColor.primary.withValues(alpha: 0.1),
              labelTextStyle: WidgetStateProperty.all(
                Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              iconTheme: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return IconThemeData(color: AppColor.primary);
                }
                return IconThemeData(color: Colors.grey);
              }),
            ),
            child: NavigationBar(
              elevation: 0,
              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: (index) {
                controller.changeIndex(index);
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Iconsax.home_2, size: 24),
                  selectedIcon: Icon(Iconsax.home_25, size: 26),
                  label: 'Shop',
                ),
                NavigationDestination(
                  icon: Icon(Iconsax.search_normal, size: 24),
                  selectedIcon: Icon(Iconsax.search_normal_1, size: 26),
                  label: 'Explore',
                ),
                NavigationDestination(
                  icon: Icon(Iconsax.shopping_cart, size: 24),
                  selectedIcon: Icon(Iconsax.shopping_cart5, size: 26),
                  label: 'Cart',
                ),
                NavigationDestination(
                  icon: Icon(Iconsax.heart, size: 24),
                  selectedIcon: Icon(Iconsax.heart5, size: 26),
                  label: 'Favourite',
                ),
                NavigationDestination(
                  icon: Icon(Iconsax.user, size: 24),
                  selectedIcon: Icon(Iconsax.user4, size: 26),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
