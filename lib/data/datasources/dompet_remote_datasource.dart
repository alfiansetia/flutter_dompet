import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_dompet/common/global_variable.dart';
import 'package:flutter_dompet/data/datasources/auth_local_datasoutce.dart';
import 'package:flutter_dompet/data/models/dompet.dart';
import 'package:flutter_dompet/data/models/dompets_response_model.dart';
import 'package:http/http.dart' as http;

class DompetRemoteDatasource {
  Future<Either<String, DompetsResponseModel>> getAll(
      {int limit = 2, int page = 1}) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse(
          '${GlobalVariables.baseUrl}/api/dompets?limit=$limit&page=$page'),
      headers: headers,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Right(DompetsResponseModel.fromJson(response.body));
    } else {
      return const Left('Server Error, please contact admin');
    }
  }

  Future<Either<String, Dompet>> show(int id) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse('${GlobalVariables.baseUrl}/api/dompets/$id'),
      headers: headers,
    );
    print(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData.containsKey('data')) {
        final Map<String, dynamic> data = responseData['data'] ?? [];
        final dompet = Dompet.fromMap(data);
        return Right(dompet);
      }
      return const Left('No data found');
    } else {
      return const Left('Server Error, please contact admin');
    }
  }
}
