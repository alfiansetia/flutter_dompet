part of 'dompet_bloc.dart';

abstract class DompetEvent extends Equatable {
  const DompetEvent();

  @override
  List<Object> get props => [];
}

class FetchAllDompetEvent extends DompetEvent {
  const FetchAllDompetEvent();

  @override
  List<Object> get props => [];
}
