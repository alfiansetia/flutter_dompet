import 'dart:convert';

import 'package:flutter_dompet/common/global_variable.dart';
import 'package:flutter_dompet/data/datasources/auth_local_datasoutce.dart';
import 'package:flutter_dompet/data/models/auth_response_model.dart';
import 'package:flutter_dompet/data/models/custom_error.dart';
import 'package:flutter_dompet/data/models/requests/login_request_model.dart';
import 'package:flutter_dompet/data/service/http_error_handler.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
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
        throw CustomError(message: "cannot Login");
      }
      final data = AuthResponseModel.fromMap(responseBody);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    final token = await AuthLocalDatasource().getToken();
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
        throw CustomError(message: "Cannot Logout");
      }
    } catch (e) {
      rethrow;
    }
  }
}
