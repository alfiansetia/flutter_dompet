import 'dart:convert';

import 'package:flutter_dompet/common/global_variable.dart';
import 'package:flutter_dompet/data/models/auth_response_model.dart';
import 'package:flutter_dompet/data/models/requests/login_request_model.dart';
import 'package:flutter_dompet/data/services/http_error_handler.dart';
import 'package:flutter_dompet/exceptions/auth_exception.dart';
import 'package:http/http.dart' as http;

class AuthApiService {
  Future<AuthResponseModel> login(LoginRequestModel model) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.post(
          Uri.parse('${GlobalVariables.baseUrl}/api/login'),
          headers: headers,
          body: model.toJson());
      if (response.statusCode != 200) {
        throw httpErrorHandler(response);
      }
      final responseBody = json.decode(response.body);
      if (responseBody.isEmpty) {
        throw AuthException("cannot Login");
      }
      return AuthResponseModel.fromMap(responseBody);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> logout({required String token}) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.post(
        Uri.parse('${GlobalVariables.baseUrl}/api/logout'),
        headers: headers,
      );
      final responseBody = json.decode(response.body);
      if (responseBody.isEmpty) {
        throw AuthException("Cannot Logout");
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
