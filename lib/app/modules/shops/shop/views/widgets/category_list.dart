import 'package:deshi_mart_ecom_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/common/widgets/custom_loading.dart';
import '../../../../../utils/api_url/api_url.dart';
import '../../../../../utils/themes/app_color.dart';
import '../../controllers/shop_controller.dart';
import '../shimmer/category_shimmer.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final ShopController controller = Get.put(ShopController());

    return SizedBox(
      height: 110,
      child: Obx(() {
        if (controller.isCategoryLoading.value) {
          return CategoryShimmer();
        }
        if (controller.filterCategory.isEmpty) {
          return const Center(child: Text("No Category Found"));
        }

        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.filterCategory.length,
          separatorBuilder: (context, index) => const SizedBox(width: 15),
          itemBuilder: (context, index) {
            final category = controller.filterCategory[index];

            final name = category.categoryName ?? "";
            final categoryImage = "${ApiUrl.imgBase}${category.categoryImage}";

            return Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    controller.selectedCategoryId.value = category.id.toString();
                    controller.selectedCategoryName.value = category.categoryName ?? "Products";
                    await controller.productsByCategory(category.id.toString());
                    Get.toNamed(Routes.PRODUCT);
                  },
                  child: Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        categoryImage,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.image_not_supported,
                          color: Colors.grey[400],
                        ),
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const Center(
                            child: CustomLoading(
                              size: 20,
                              color: AppColor.primary,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 70,
                  child: Text(
                    name,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
