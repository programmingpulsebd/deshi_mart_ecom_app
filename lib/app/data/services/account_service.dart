import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/api_url/api_url.dart';
import '../auth_services/auth_session.dart';

class AccountService {
  Future<http.Response> changePassword(Map<String, dynamic> data) async {
    try {
      final AuthSession authSession = AuthSession();
      final token = await authSession.getToken();

      final url = Uri.parse(ApiUrl.changePassword);
      final body = jsonEncode(data);

      final response = await http.post(
        url,
        body: body,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      return response;
    } catch (e) {
      throw Exception("Error : $e");
    }
  }

  Future<http.Response> deleteAccount() async {
    try {
      final AuthSession authSession = AuthSession();
      final token = await authSession.getToken();

      final url = Uri.parse(ApiUrl.deleteAccount);

      final response = await http.delete(
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




  Future<http.Response> sendOtp (String email) async {



    try{

      final data = jsonEncode(
          {
            "email": email,
          }
      );

      final url = Uri.parse(ApiUrl.sendOtp);
      final response = await http.post(url,
        body: data,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      return response;

    } catch(e){
      throw Exception("Error : $e");
    }




  }


  Future<http.Response> verifyOTP (String email,String otp) async {



    try{

      final data = jsonEncode(
          {
            "email": email,
            "otp": otp,
          }
      );

      final url = Uri.parse(ApiUrl.sendOtp);
      final response = await http.post(url,
        body: data,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      return response;

    } catch(e){
      throw Exception("Error : $e");
    }




  }

  Future<http.Response> resetPassword(
      String email,
      String password,
      String passwordConfirmation,
      ) async {



    final url = Uri.parse(ApiUrl.resetPassword);

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        "Accept": "application/json"
      },
      body: jsonEncode({
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      }),
    );

   return response;

    }








  }




