import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_dompet/common/global_variable.dart';
import 'package:flutter_dompet/data/models/custom_error.dart';
import 'package:flutter_dompet/data/models/transaksi.dart';
import 'package:flutter_dompet/data/models/transaksis_response_model.dart';
import 'package:flutter_dompet/data/services/http_error_handler.dart';
import 'package:flutter_dompet/exceptions/transaksi_exception.dart';

class TransaksiApiService {
  final String token;
  TransaksiApiService({
    required this.token,
  });

  Future<TransaksisResponseModel> getAll({String? query}) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse(
            '${GlobalVariables.baseUrl}/api/transaksi-paginate?limit=20&$query&order_id_desc=true'),
        headers: headers,
      );
      if (response.statusCode != 200) {
        throw httpErrorHandler(response);
      }
      final responseBody = json.decode(response.body);

      if (responseBody.isEmpty) {
        throw TransaksiException('Cannot get the data Transaksi');
      }
      return TransaksisResponseModel.fromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }

  Future<Transaksi> show(int id) async {
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
