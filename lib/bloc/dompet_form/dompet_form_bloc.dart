import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dompet/data/models/custom_error.dart';
import 'package:flutter_dompet/data/models/dompet.dart';
import 'package:flutter_dompet/data/repository/auth_repository.dart';
import 'package:flutter_dompet/data/repository/dompet_repository.dart';

part 'dompet_form_event.dart';
part 'dompet_form_state.dart';

class DompetFormBloc extends Bloc<DompetFormEvent, DompetFormState> {
  final auth = AuthRepository();
  DompetFormBloc() : super(DompetFormState.initial()) {
    on<DetailDompetFormEvent>(_detail);
  }

  Future<void> _detail(
      DetailDompetFormEvent event, Emitter<DompetFormState> emit) async {
    emit(state.copyWith(status: DompetFormStatus.loading));

    try {
      final Dompet model = await DompetRepository(auth: auth).show(event.id);
      emit(state.copyWith(status: DompetFormStatus.loaded, model: model));
    } on CustomError catch (e) {
      emit(state.copyWith(status: DompetFormStatus.error, error: e));
    }
  }
}
