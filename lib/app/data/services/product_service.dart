import 'package:deshi_mart_ecom_app/app/utils/api_url/api_url.dart';
import 'package:http/http.dart' as http;

class ProductsService {

  Future<http.Response> category() async {
    try {
      final url = Uri.parse(ApiUrl.category);

      final response = await http.get(url);

      return response;
    } catch (e) {
      throw Exception("Error : $e");
    }
  }

  Future<http.Response> productsByCategory(String id) async {
    try {
      final url = Uri.parse("${ApiUrl.productsByCategory}$id");

      final response = await http.get(url);

      return response;
    } catch (e) {
      throw Exception("Error : $e");
    }
  }

  Future<http.Response> latestProduct() async {
    try {
      final url = Uri.parse(ApiUrl.latestProducts);

      final response = await http.get(url);

      return response;
    } catch (e) {
      throw Exception("Error : $e");
    }
  }

  Future<http.Response> allProduct() async {
    try {
      final url = Uri.parse(ApiUrl.allProducts);

      final response = await http.get(url);

      return response;
    } catch (e) {
      throw Exception("Error : $e");
    }
  }



  Future<http.Response> products() async {
    try {
      final url = Uri.parse(ApiUrl.products);

      final response = await http.get(url);

      return response;
    } catch (e) {
      throw Exception("Error : $e");
    }
  }


  Future<http.Response> relatedProducts(String id) async {
    try {
      final url = Uri.parse("${ApiUrl.relatedProducts}$id/related");

      final response = await http.get(url);

      return response;
    } catch (e) {
      throw Exception("Error : $e");
    }
  }



}
