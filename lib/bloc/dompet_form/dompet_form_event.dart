part of 'dompet_form_bloc.dart';

abstract class DompetFormEvent extends Equatable {
  const DompetFormEvent();

  @override
  List<Object> get props => [];
}

class DetailDompetFormEvent extends DompetFormEvent {
  final int id;
  DetailDompetFormEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
