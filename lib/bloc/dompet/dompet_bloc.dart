import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dompet/data/models/custom_error.dart';
import 'package:flutter_dompet/data/models/dompet.dart';
import 'package:flutter_dompet/data/models/dompets_response_model.dart';
import 'package:flutter_dompet/data/repository/auth_repository.dart';
import 'package:flutter_dompet/data/repository/dompet_repository.dart';

part 'dompet_event.dart';
part 'dompet_state.dart';

class DompetBloc extends Bloc<DompetEvent, DompetState> {
  final auth = AuthRepository();
  List<Dompet>? data = [];
  DompetBloc() : super(DompetState.initial()) {
    on<FetchAllDompetEvent>(_getAll);
  }

  Future<void> _getAll(
      FetchAllDompetEvent event, Emitter<DompetState> emit) async {
    emit(state.copyWith(status: DompetStatus.loading));

    try {
      final DompetsResponseModel model =
          await DompetRepository(auth: auth).getAll(query: "limit=3");
      data = model.data;
      emit(state.copyWith(status: DompetStatus.loaded, model: data));
    } on CustomError catch (e) {
      emit(state.copyWith(status: DompetStatus.error, error: e));
    } catch (e) {
      emit(state.copyWith(
          status: DompetStatus.error,
          error: CustomError(message: e.toString())));
    }
  }
}
