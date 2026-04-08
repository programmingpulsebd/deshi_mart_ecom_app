import 'dart:convert';

import 'package:deshi_mart_ecom_app/app/data/model/banners.dart';
import 'package:deshi_mart_ecom_app/app/data/model/category.dart';
import 'package:deshi_mart_ecom_app/app/data/model/products.dart';
import 'package:deshi_mart_ecom_app/app/data/services/product_service.dart';
import 'package:get/get.dart';

import '../../../../data/services/banner_services.dart';

class ShopController extends GetxController {
  final ProductsService categoryService = ProductsService();
  final BannerServices bannerService = BannerServices();

  final category = <Category>[].obs;
  final products = <Products>[].obs;
  final latestProducts = <Products>[].obs;
  final allProducts = <Products>[].obs;
  final relatedProduct = <Products>[].obs;
  final banner = <Banners>[].obs;

  var isCategoryLoading = false.obs;
  var isProductLoading = false.obs;
  var isLatestProductLoading = false.obs;
  var isAllProductLoading = false.obs;
  var isRelatedProductLoading = false.obs;
  var isBannerLoading = false.obs;

  var filterCategory = <Category>[].obs;
  final searchText = ''.obs;


  final selectedCategoryId = ''.obs;
  final selectedCategoryName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategory();
    latestProduct();
    allProduct();
    banners();
  }

  Future<void> fetchCategory() async {
    try {
      isCategoryLoading.value = true;
      final response = await categoryService.category();

      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        category.clear();
        List list = result['data'];
        category.value = list.map((e) => Category.fromJson(e)).toList();
        filterCategory.value = category;
      } else {
        throw Exception("Error : ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error : $e");
    } finally {
      isCategoryLoading.value = false;
    }
  }

  void applySearch(String query) {
    searchText.value = query;
    if (query.isEmpty) {
      filterCategory.value = category;

    } else {
      filterCategory.value = category
          .where((category) =>
          category.categoryName!.toLowerCase().contains(query.toLowerCase()))

          .toList();
    }


  }







  Future<void> productsByCategory(String id) async {
    try {
      isProductLoading.value = true;
      final response = await categoryService.productsByCategory(id);

      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        products.clear();
        List list = result['data'];
        products.value = list.map((e) => Products.fromJson(e)).toList();
      } else {
        throw Exception("Error : ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error : $e");
    } finally {
      isProductLoading.value = false;
    }
  }

  Future<void> latestProduct() async {
    try {
      isLatestProductLoading.value = true;
      final response = await categoryService.latestProduct();

      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        latestProducts.clear();
        List list = result['data'];
        latestProducts.value = list.map((e) => Products.fromJson(e)).toList();
      } else {
        throw Exception("Error : ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error : $e");
    } finally {
      isLatestProductLoading.value = false;
    }
  }

  Future<void> allProduct() async {
    try {
      isAllProductLoading.value = true;
      final response = await categoryService.allProduct();
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        allProducts.clear();
        List list = result['data'];
        allProducts.value = list.map((e) => Products.fromJson(e)).toList();
      } else {
        throw Exception("Error : ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error : $e");
    } finally {
      isAllProductLoading.value = false;
    }
  }

  Future<void> relatedProducts(String id) async {
    try {
      isRelatedProductLoading.value = true;
      final response = await categoryService.relatedProducts(id);

      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        relatedProduct.clear();
        List list = result['data'];
        relatedProduct.value = list.map((e) => Products.fromJson(e)).toList();
      }
    } catch (e) {
      throw Exception("Error : $e");
    } finally {
      isRelatedProductLoading.value = false;
    }
  }

  Future<void> banners() async {
    try {
      isBannerLoading.value = true;
      final response = await bannerService.banners();

      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        banner.clear();

        for (int i = 0; i < result.length; i++) {
          banner.add(Banners.fromJson(result[i]));
        }
        print(banner);
      } else {
        throw Exception("Error : ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error : $e");
    } finally {
      isBannerLoading.value = false;
    }
  }

  // banners
  var currentIndex = 0.obs;

  void updateIndex(int index) {
    currentIndex.value = index;
  }
}
