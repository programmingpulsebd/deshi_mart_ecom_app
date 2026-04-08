import 'dart:convert';

import 'package:get/get.dart';

import '../../../../data/model/products.dart';
import '../../../../data/services/product_service.dart';

class ExploreController extends GetxController {
  final isLoading = false.obs;
  final products = <Products>[].obs;
  final filteredProducts = <Products>[].obs;

  final searchText = ''.obs;

  final productsService = ProductsService();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;

      final response = await productsService.products();

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        List<dynamic> productList = data["data"];
        products.clear();
        products.value = productList.map((e) => Products.fromJson(e)).toList();
        filteredProducts.value = products;

      } else {
        print("Error : ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error : $e");
    } finally {
      isLoading.value = false;
    }
  }


  void filterProducts(String query) {
    searchText.value = query;
    if (query.isEmpty) {
      filteredProducts.value = products;
    } else {
      filteredProducts.value = products
          .where((product) =>
          product.productName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }





}
