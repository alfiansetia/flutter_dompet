import 'package:dartz/dartz.dart';
import 'package:flutter_dompet/common/global_variable.dart';
import 'package:flutter_dompet/data/datasources/auth_local_datasoutce.dart';
import 'package:flutter_dompet/data/models/dompets_response_model.dart';
import 'package:http/http.dart' as http;

class UserRemoteDatasource {
  Future<Either<String, DompetsResponseModel>> getDompets() async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse('${GlobalVariables.baseUrl}/api/users'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return Right(DompetsResponseModel.fromJson(response.body));
    } else {
      return const Left('Server Error, please contact admin');
    }
  }
}
