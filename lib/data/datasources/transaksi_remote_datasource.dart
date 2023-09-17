import 'dart:convert';
// import 'package:dartz/dartz.dart';
import 'package:flutter_dompet/common/global_variable.dart';
import 'package:flutter_dompet/data/datasources/auth_local_datasoutce.dart';
import 'package:flutter_dompet/data/models/custom_error.dart';
import 'package:flutter_dompet/data/models/transaksi.dart';
import 'package:flutter_dompet/data/models/transaksis_response_model.dart';
import 'package:flutter_dompet/data/service/http_error_handler.dart';
import 'package:http/http.dart' as http;

class TransaksiRemoteDatasource {
  Future<TransaksisResponseModel> getAll() async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.get(
        Uri.parse('${GlobalVariables.baseUrl}/api/transaksis?page=5&limit=20'),
        headers: headers,
      );
      if (response.statusCode != 200) {
        throw httpErrorHandler(response);
      }
      print('all');

      final responseBody = json.decode(response.body);
      if (responseBody.isEmpty) {
        throw CustomError(message: "Error!");
      }
      return TransaksisResponseModel.fromMap(responseBody);
    } catch (e) {
      rethrow;
    }
  }

  Future<Transaksi> show(String id) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.get(
        Uri.parse('${GlobalVariables.baseUrl}/api/transaksis/$id'),
        headers: headers,
      );

      if (response.statusCode != 200) {
        throw httpErrorHandler(response);
      }
      print('show');
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData.containsKey('data')) {
        final Map<String, dynamic> data = responseData['data'] ?? [];
        return Transaksi.fromMap(data);
      }
      throw CustomError(message: 'No data!');
    } catch (e) {
      rethrow;
    }
  }
}
