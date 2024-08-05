import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dompet/data/models/custom_error.dart';
import 'package:flutter_dompet/data/models/transaksi.dart';
import 'package:flutter_dompet/data/models/transaksis_response_model.dart';
import 'package:flutter_dompet/data/repository/auth_repository.dart';
import 'package:flutter_dompet/data/repository/transaksi_repository.dart';

part 'transaksi_event.dart';
part 'transaksi_state.dart';

class TransaksiBloc extends Bloc<TransaksiEvent, TransaksiState> {
  bool lastStatus = false;
  final auth = AuthRepository();
  int page = 1;
  List<Transaksi> data = [];
  TransaksiBloc() : super(TransaksiState.initial()) {
    on<FetchAllTransaksiEvent>(_getAll);
  }

  Future<void> _getAll(
      FetchAllTransaksiEvent event, Emitter<TransaksiState> emit) async {
    if (event.page == 1) {
      data.clear();
      emit(state.copyWith(
          status: TransaksiStatus.loading, hasMax: false, page: 1));
    } else {
      emit(state.copyWith(status: TransaksiStatus.loading, hasMax: false));
    }

    // emit(state.copyWith(
    //     status: TransaksiStatus.error,
    //     hasMax: true,
    //     error: CustomError(message: 'Error!')));
    try {
      final TransaksisResponseModel model =
          await TransaksiRepository(auth: auth)
              .getAll(query: "page=${event.page}&${event.query}");
      final newData = model.data as Iterable<Transaksi>;
      data.addAll(newData);

      // print(event.page);

      emit(state.copyWith(
        status: TransaksiStatus.loaded,
        model: data,
        hasMax: model.meta?.currentPage == model.meta?.lastPage,
        page: event.page,
      ));
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          status: TransaksiStatus.error,
          error: e,
          hasMax: true,
          page: 1,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: TransaksiStatus.error,
          error: CustomError(message: e.toString()),
          hasMax: true,
          page: 1,
        ),
      );
    }
  }

  // Future<void> _getAll(
  //     FetchAllTransaksiEvent event, Emitter<TransaksiState> emit) async {
  //   emit(state.copyWith(status: TransaksiStatus.loading, hasMax: false));

  //   if (state.hasMax) return;
  //   print(data.length);
  //   try {
  //     final TransaksisResponseModel model =
  //         await TransaksiRepository(auth: auth).getAll(query: "page=$page");
  //     if (model.meta?.currentPage != model.meta?.lastPage) {
  //       lastStatus = true;
  //       data.addAll(model.data as Iterable<Transaksi>);
  //       page++;
  //     }
  //     emit(state.copyWith(
  //         status: TransaksiStatus.loaded, model: data, hasMax: lastStatus));
  //   } on CustomError catch (e) {
  //     emit(state.copyWith(
  //         status: TransaksiStatus.error, error: e, hasMax: true));
  //   }
  // }
}
