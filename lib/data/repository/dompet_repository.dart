import 'package:flutter_dompet/data/models/custom_error.dart';
import 'package:flutter_dompet/data/models/dompets_response_model.dart';
import 'package:flutter_dompet/data/repository/auth_repository.dart';
import 'package:flutter_dompet/data/services/dompet_api_service.dart';
import 'package:flutter_dompet/exceptions/dompet_exception.dart';

class DompetRepository {
  DompetRepository({
    required this.auth,
  });

  final AuthRepository auth;

  // final _dompetServices = DompetApiService(auth: auth);

  Future getAll({String? query}) async {
    try {
      final token = await auth.getToken();
      final DompetsResponseModel data =
          await DompetApiService(token: token).getAll(query: query);
      return data;
    } on DompetException catch (e) {
      throw CustomError(message: e.message);
    } catch (e) {
      throw CustomError(message: e.toString());
    }
  }

  Future show(int id) async {
    try {
      final token = await auth.getToken();
      final dompet = await DompetApiService(token: token).show(id);
      return dompet;
    } on DompetException catch (e) {
      throw CustomError(message: e.message);
    } catch (e) {
      throw CustomError(message: e.toString());
    }
  }

  // Future create(Dompet dompet) => dompetServices.create(dompet);

  // Future update(Dompet dompet) => dompetServices.update(dompet);

  // Future delete(int id) => dompetServices.delete(id);
}
