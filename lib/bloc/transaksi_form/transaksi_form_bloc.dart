import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dompet/data/models/custom_error.dart';
import 'package:flutter_dompet/data/models/transaksi.dart';
import 'package:flutter_dompet/data/repository/auth_repository.dart';
import 'package:flutter_dompet/data/repository/transaksi_repository.dart';

part 'transaksi_form_event.dart';
part 'transaksi_form_state.dart';

class TransaksiFormBloc extends Bloc<TransaksiFormEvent, TransaksiFormState> {
  final auth = AuthRepository();
  TransaksiFormBloc() : super(TransaksiFormState.initial()) {
    on<DetailTransaksiFormEvent>(_detail);
  }

  Future<void> _detail(
      DetailTransaksiFormEvent event, Emitter<TransaksiFormState> emit) async {
    emit(state.copyWith(status: TransaksiFormStatus.loading));

    try {
      final Transaksi model =
          await TransaksiRepository(auth: auth).show(event.id);
      emit(state.copyWith(status: TransaksiFormStatus.loaded, model: model));
    } on CustomError catch (e) {
      emit(state.copyWith(status: TransaksiFormStatus.error, error: e));
    }
  }
}
