import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../../data/common/widgets/custom_loading.dart';
import '../../../../../data/model/products.dart';
import '../../../../../utils/api_url/api_url.dart';
import '../../../../../utils/themes/app_color.dart';

class ImageGallery extends StatelessWidget {
  const ImageGallery({super.key, required this.products});

  final Products? products;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items:
          products?.imageGallery?.map((image) {
            final imageUrl = "${ApiUrl.imgBase}$image";
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.fill,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(
                    child: CustomLoading(size: 40, color: AppColor.primary),
                  );
                },
                errorBuilder: (_, _, _) => Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 40,
                    color: Colors.grey[400],
                  ),
                ),
              ),
            );
          }).toList() ??
          [],
      options: CarouselOptions(
        height: 280,
        viewportFraction: 0.9,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
      ),
    );
  }
}
