import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dompet/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_dompet/data/models/custom_error.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutState.initial()) {
    on<FetchLogoutEvent>(_logout);
  }

  Future<void> _logout(
    FetchLogoutEvent event,
    Emitter<LogoutState> emit,
  ) async {
    emit(state.copyWith(status: LogoutStatus.loading));

    try {
      await AuthRemoteDatasource().logout();
      emit(state.copyWith(status: LogoutStatus.loaded));
    } catch (e) {
      emit(state.copyWith(status: LogoutStatus.error, error: e as CustomError));
    }
  }
}
