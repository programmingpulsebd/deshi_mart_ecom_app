import 'dart:convert';
import 'dart:io';

import 'package:deshi_mart_ecom_app/app/data/auth_services/auth_session.dart';
import 'package:http/http.dart' as http;

import '../../utils/api_url/api_url.dart';

class AuthServices {
  Future<http.Response> register(Map<String, dynamic> data) async {
    try {
      final url = Uri.parse(ApiUrl.register);
      final body = jsonEncode(data);

      final response = await http.post(
        url,
        body: body,

        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      return response;
    } catch (e) {
      throw Exception("Error : $e");
    }
  }

  Future<http.Response> login(Map<String, dynamic> data) async {
    try {
      final url = Uri.parse(ApiUrl.login);
      final body = jsonEncode(data);

      final response = await http.post(
        url,
        body: body,

        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      return response;
    } catch (e) {
      throw Exception("Error : $e");
    }
  }

  Future<http.Response> profile() async {
    final AuthSession authSession = AuthSession();
    final token = await authSession.getToken();

    try {
      final url = Uri.parse(ApiUrl.profile);

      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      return response;
    } catch (e) {
      throw Exception("Error : $e");
    }
  }

  Future<http.Response> updateProfile(
    Map<String, dynamic> data,
    File? image,
  ) async {
    final AuthSession authSession = AuthSession();
    final token = await authSession.getToken();

    try {
      final url = Uri.parse(ApiUrl.updateProfile);

      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $token';

      request.fields['full_name'] = data['full_name'];
      request.fields['phone'] = data['phone'];

      request.files.add(
        await http.MultipartFile.fromPath('profile_image', image!.path),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      return response;
    } catch (e) {
      throw Exception("Error : $e");
    }
  }

  Future<http.Response> updateDeliveryAddress(Map<String, dynamic> data) async {
    final AuthSession authSession = AuthSession();
    final token = await authSession.getToken();
    try {
      final url = Uri.parse(ApiUrl.updateDeliveryAddress);

      final body = jsonEncode(data);

      final response = await http.post(
        url,
        body: body,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      return response;
    } catch (e) {
      throw Exception("Error : $e");
    }
  }
}
