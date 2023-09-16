import 'package:bloc/bloc.dart';
import 'package:flutter_dompet/data/datasources/transaksi_remote_datasource.dart';
import 'package:flutter_dompet/data/models/transaksi.dart';
import 'package:flutter_dompet/data/models/transaksis_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaksi_event.dart';
part 'transaksi_state.dart';
part 'transaksi_bloc.freezed.dart';

class TransaksiBloc extends Bloc<TransaksiEvent, TransaksiState> {
  TransaksiBloc() : super(const _Initial()) {
    on<_GetAll>((event, emit) async {
      emit(const _Loading());
      final result = await TransaksiRemoteDatasource().getTransaksis();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });

    on<_GetDetail>((event, emit) async {
      emit(const _Loading());
      final result = await TransaksiRemoteDatasource().show(event.id);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_DetailLoaded(r)),
      );
    });
  }
}
