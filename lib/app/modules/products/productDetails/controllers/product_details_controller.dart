import 'dart:convert';

import 'package:get/get.dart';

import '../../../../data/model/products.dart';
import '../../../../data/services/product_service.dart';

class ProductDetailsController extends GetxController {

  final ProductsService productsService = ProductsService();
  final products = <Products>[].obs;
  var isProductLoading = false.obs;


  Future<void> relatedProducts(String id) async {
    try {
      isProductLoading.value = true;
      final response = await productsService.relatedProducts(id);

      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        products.clear();
        List list = result['data'];
        products.value = list.map((e) => Products.fromJson(e)).toList();
      }
    } catch (e) {
      throw Exception("Error : $e");
    } finally {
      isProductLoading.value = false;
    }
  }
}
