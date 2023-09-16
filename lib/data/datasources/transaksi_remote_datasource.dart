import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_dompet/common/global_variable.dart';
import 'package:flutter_dompet/data/datasources/auth_local_datasoutce.dart';
import 'package:flutter_dompet/data/models/transaksi.dart';
import 'package:flutter_dompet/data/models/transaksis_response_model.dart';
import 'package:http/http.dart' as http;

class TransaksiRemoteDatasource {
  Future<Either<String, TransaksisResponseModel>> getTransaksis() async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse('${GlobalVariables.baseUrl}/api/transaksis?page=5&limit=20'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return Right(TransaksisResponseModel.fromJson(response.body));
    } else {
      return const Left('Server Error, please contact admin');
    }
  }

  Future<Either<String, Transaksi>> show(int id) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse('${GlobalVariables.baseUrl}/api/transaksis/$id'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData.containsKey('data')) {
        final Map<String, dynamic> data = responseData['data'] ?? [];

        final transaksi = Transaksi.fromMap(data);
        return Right(transaksi);
      }
      return const Left('No data found');
    } else {
      return const Left('Server Error, please contact admin');
    }
  }
}
