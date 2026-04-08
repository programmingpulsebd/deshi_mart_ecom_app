import 'package:carousel_slider/carousel_slider.dart';
import 'package:deshi_mart_ecom_app/app/utils/api_url/api_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/themes/app_color.dart';
import '../../controllers/shop_controller.dart';
import '../../../../../data/common/widgets/custom_loading.dart';
import '../shimmer/banner_shimmer.dart';

class BannerSlider extends StatelessWidget {
  final ShopController controller;

  const BannerSlider({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isBannerLoading.value) {
        return BannerShimmer();
      }

      if (controller.banner.isEmpty) {
        return const SizedBox(
          height: 140,
          child: Center(child: Text("No Banners Found")),
        );
      }

      final bannerImages = controller.banner
          .map((b) => "${ApiUrl.imgBase}${b.bannerImage}")
          .toList();

      return Column(
        children: [
          CarouselSlider(
            items: bannerImages.map((i) {
              return GestureDetector(
                onTap: () async {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      i,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const Center(
                          child: CustomLoading(
                            size: 40,
                            color: AppColor.primary,
                          ),
                        );
                      },
                      errorBuilder: (_, _, _) => Container(
                        color: Colors.grey[100],
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: Colors.grey,
                            size: 36,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 130,
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayCurve: Curves.easeInOutCubic,
              autoPlayAnimationDuration: const Duration(milliseconds: 600),
              enlargeCenterPage: true,
              enlargeFactor: 0.05,
              onPageChanged: (index, _) => controller.updateIndex(index),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(bannerImages.length, (index) {
              final isActive = controller.currentIndex.value == index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: isActive ? 22 : 7,
                height: 7,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isActive ? AppColor.primary : Colors.grey[300],
                ),
              );
            }),
          ),
        ],
      );
    });
  }
}
