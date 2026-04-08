import 'package:http/http.dart' as http;

import '../../utils/api_url/api_url.dart';
class BannerServices {
  Future<http.Response> banners() async {
    try {
      final url = Uri.parse(ApiUrl.banners);

      final response = await http.get(url);

      return response;
    } catch (e) {
      throw Exception("Error : $e");
    }
  }
}