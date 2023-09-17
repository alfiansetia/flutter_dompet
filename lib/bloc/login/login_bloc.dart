import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dompet/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_dompet/data/models/auth_response_model.dart';
import 'package:flutter_dompet/data/models/custom_error.dart';
import 'package:flutter_dompet/data/models/requests/login_request_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<FetchLoginEven>(_login);
  }

  Future<void> _login(
    FetchLoginEven event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      final AuthResponseModel model =
          await AuthRemoteDatasource().login(event.model);
      emit(state.copyWith(status: LoginStatus.loaded, model: model));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.error, error: e as CustomError));
    }
  }
}
