import 'package:flutter_dompet/data/datasources/auth_local_datasoutce.dart';
import 'package:flutter_dompet/data/models/auth_response_model.dart';
import 'package:flutter_dompet/data/models/custom_error.dart';
import 'package:flutter_dompet/data/models/requests/login_request_model.dart';
import 'package:flutter_dompet/data/services/auth_api_service.dart';
import 'package:flutter_dompet/exceptions/auth_exception.dart';

class AuthRepository {
  final _authApiService = AuthApiService();

  Future login({required LoginRequestModel data}) async {
    try {
      final AuthResponseModel response = await _authApiService.login(data);
      return response;
    } on AuthException catch (e) {
      throw CustomError(message: e.message);
    } catch (e) {
      throw CustomError(message: e.toString());
    }
  }

  Future logout() async {
    try {
      final bool response = await _authApiService.logout(token: "dsfsdg");
      return response;
    } on AuthException catch (e) {
      throw CustomError(message: e.message);
    } catch (e) {
      throw CustomError(message: e.toString());
    }
  }

  Future getToken() async {
    try {
      final String token = await AuthLocalDatasource().getToken();
      if (token.isEmpty) {
        throw AuthException('Token not found');
      }
      return token;
    } catch (e) {
      rethrow;
    }
  }
}
