import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dompet/data/datasources/transaksi_remote_datasource.dart';
import 'package:flutter_dompet/data/models/custom_error.dart';
import 'package:flutter_dompet/data/models/transaksi.dart';
import 'package:flutter_dompet/data/models/transaksis_response_model.dart';

part 'transaksi_event.dart';
part 'transaksi_state.dart';

class TransaksiBloc extends Bloc<TransaksiEvent, TransaksiState> {
  TransaksisResponseModel? data;
  TransaksiBloc() : super(TransaksiState.initial()) {
    on<FetchAllTransaksiEvent>(_getAll);

    on<FetchShowTransaksiEvent>(_show);
  }

  Future<void> _getAll(
      FetchAllTransaksiEvent event, Emitter<TransaksiState> emit) async {
    emit(state.copyWith(status: TransaksiStatus.loading));

    try {
      final TransaksisResponseModel model =
          await TransaksiRemoteDatasource().getAll();
      data = model;
      emit(state.copyWith(status: TransaksiStatus.loaded, model: model));
    } catch (e) {
      emit(state.copyWith(
          status: TransaksiStatus.error, error: e as CustomError));
    }
  }

  Future<void> _show(
      FetchShowTransaksiEvent event, Emitter<TransaksiState> emit) async {
    emit(state.copyWith(status: TransaksiStatus.loading));

    try {
      final Transaksi model = await TransaksiRemoteDatasource().show(event.id);
      emit(state.copyWith(
          status: TransaksiStatus.detailLoaded, model: data, detail: model));
    } catch (e) {
      emit(state.copyWith(
          status: TransaksiStatus.error,
          error: CustomError(message: e.toString())));
    }
  }
}
