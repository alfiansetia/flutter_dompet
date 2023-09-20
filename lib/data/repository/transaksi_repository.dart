import 'package:flutter_dompet/data/models/custom_error.dart';
import 'package:flutter_dompet/data/models/transaksi.dart';
import 'package:flutter_dompet/data/models/transaksis_response_model.dart';
import 'package:flutter_dompet/data/repository/auth_repository.dart';
import 'package:flutter_dompet/data/services/transaksi_api_service.dart';
import 'package:flutter_dompet/exceptions/transaksi_exception.dart';

class TransaksiRepository {
  final AuthRepository auth;
  TransaksiRepository({
    required this.auth,
  });
  Future getAll({String? query}) async {
    try {
      final String token = await auth.getToken();
      final TransaksisResponseModel transaksi =
          await TransaksiApiService(token: token).getAll(query: query);
      return transaksi;
    } on TransaksiException catch (e) {
      throw CustomError(message: e.message);
    } catch (e) {
      throw CustomError(message: e.toString());
    }
  }

  Future show(int id) async {
    try {
      final String token = await auth.getToken();
      final Transaksi transaksi =
          await TransaksiApiService(token: token).show(id);

      return transaksi;
    } on TransaksiException catch (e) {
      throw CustomError(message: e.message);
    } catch (e) {
      throw CustomError(message: e.toString());
    }
  }
}
