import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_dompet/common/global_variable.dart';
import 'package:flutter_dompet/data/models/custom_error.dart';
import 'package:flutter_dompet/data/models/dompet.dart';
import 'package:flutter_dompet/data/models/dompets_response_model.dart';
import 'package:flutter_dompet/data/services/http_error_handler.dart';
import 'package:flutter_dompet/exceptions/dompet_exception.dart';

class DompetApiService {
  DompetApiService({
    required this.token,
  });

  final String token;

  Future<DompetsResponseModel> getAll({String? query}) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse('${GlobalVariables.baseUrl}/api/dompets?$query'),
        headers: headers,
      );
      if (response.statusCode != 200) {
        throw httpErrorHandler(response);
      }
      final responseBody = json.decode(response.body);
      if (responseBody.isEmpty) {
        throw DompetException('Cannot get the data Dompet');
      }
      return DompetsResponseModel.fromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Dompet>> get({String? query}) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse('${GlobalVariables.baseUrl}/api/dompets?$query'),
        headers: headers,
      );
      if (response.statusCode != 200) {
        throw httpErrorHandler(response);
      }

      final responseBody = json.decode(response.body);
      if (responseBody.isEmpty) {
        throw CustomError(message: "Error!");
      }
      List<Dompet> dompets = [];
      if (responseBody != null && responseBody['data'] != null) {
        List<dynamic> dompetList = responseBody['data'];
        dompets = dompetList.map((data) => Dompet.fromMap(data)).toList();
      }

      return dompets;
    } catch (e) {
      rethrow;
    }
  }

  Future<Dompet> show(int id) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.get(
        Uri.parse('${GlobalVariables.baseUrl}/api/dompets/$id'),
        headers: headers,
      );

      if (response.statusCode != 200) {
        throw httpErrorHandler(response);
      }
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData.containsKey('data')) {
        final Map<String, dynamic> data = responseData['data'] ?? [];
        return Dompet.fromMap(data);
      }
      throw CustomError(message: 'No data!');
    } catch (e) {
      rethrow;
    }
  }
}
