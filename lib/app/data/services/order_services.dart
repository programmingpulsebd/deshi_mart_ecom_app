import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../utils/api_url/api_url.dart';
import '../auth_services/auth_session.dart';

class OrderServices {

   Future<Map<String, dynamic>> placeOrder({
    required Map<String, dynamic> body,
  }) async {

    final AuthSession authSession = AuthSession();
    final token = await authSession.getToken();

    final url = Uri.parse(ApiUrl.orders);

    try {
      final response = await http.post(
        url,
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {
          "success": true,
          "data": data,
        };
      } else {
        return {
          "success": false,
          "message": data["message"] ?? "Something went wrong",
        };
      }

    } catch (e) {
      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }


   Future<http.Response> getOrdersByStatus(String status) async {

     final AuthSession authSession = AuthSession();
     final token = await authSession.getToken();

     final Uri url = Uri.parse("${ApiUrl.getOrdersByStatus}?order_status=$status");

     final response =  await http.get(
       url,
       headers: {
         'Accept': 'application/json',
         'Authorization': 'Bearer $token',
       },
     );

     return response;

   }














}