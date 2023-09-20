part of 'dompet_bloc.dart';

enum DompetStatus {
  initial,
  loading,
  loaded,
  error,
}

class DompetState extends Equatable {
  DompetState({
    required this.error,
    required this.model,
    required this.status,
  });

  factory DompetState.initial() => DompetState(
        error: CustomError(),
        model: [],
        status: DompetStatus.initial,
      );

  final CustomError error;
  final List<Dompet> model;
  final DompetStatus status;

  @override
  List<Object> get props => [error, model, status];

  DompetState copyWith({
    CustomError? error,
    List<Dompet>? model,
    DompetStatus? status,
  }) {
    return DompetState(
      error: error ?? this.error,
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }
}
