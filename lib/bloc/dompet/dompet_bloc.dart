import 'package:bloc/bloc.dart';
import 'package:flutter_dompet/data/datasources/dompet_remote_datasource.dart';
import 'package:flutter_dompet/data/models/dompet.dart';
import 'package:flutter_dompet/data/models/dompets_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dompet_event.dart';
part 'dompet_state.dart';
part 'dompet_bloc.freezed.dart';

class DompetBloc extends Bloc<DompetEvent, DompetState> {
  DompetBloc() : super(const _Initial()) {
    on<_GetAll>((event, emit) async {
      emit(const _Loading());
      final result = await DompetRemoteDatasource()
          .getAll(limit: event.limit, page: event.page);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });

    on<_GetDetail>((event, emit) async {
      emit(const _Loading());
      final result = await DompetRemoteDatasource().show(event.id);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_DetailLoaded(r)),
      );
    });
  }
}
