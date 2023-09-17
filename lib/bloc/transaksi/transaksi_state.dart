part of 'transaksi_bloc.dart';

enum TransaksiStatus {
  initial,
  loading,
  loaded,
  detailLoaded,
  error,
}

class TransaksiState extends Equatable {
  TransaksiState({
    required this.error,
    required this.model,
    required this.status,
    required this.detail,
  });

  factory TransaksiState.initial() => TransaksiState(
      error: CustomError(message: ''),
      model: TransaksisResponseModel(),
      status: TransaksiStatus.initial,
      detail: Transaksi.initial());

  final Transaksi detail;
  final CustomError error;
  final TransaksisResponseModel model;
  final TransaksiStatus status;

  @override
  List<Object> get props => [error, model, status, detail];

  @override
  String toString() {
    return 'TransaksiState(error: $error, model: $model, status: $status, detail: $detail)';
  }

  TransaksiState copyWith({
    CustomError? error,
    TransaksisResponseModel? model,
    TransaksiStatus? status,
    Transaksi? detail,
  }) {
    return TransaksiState(
      error: error ?? this.error,
      model: model ?? this.model,
      status: status ?? this.status,
      detail: detail ?? this.detail,
    );
  }
}
