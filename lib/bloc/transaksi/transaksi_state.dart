part of 'transaksi_bloc.dart';

enum TransaksiStatus {
  initial,
  loading,
  loaded,
  error,
}

class TransaksiState extends Equatable {
  TransaksiState({
    required this.error,
    required this.model,
    required this.status,
    required this.hasMax,
    required this.page,
  });

  factory TransaksiState.initial() => TransaksiState(
        error: CustomError(),
        model: [],
        status: TransaksiStatus.initial,
        hasMax: true,
        page: 1,
      );

  final CustomError error;
  final List<Transaksi> model;
  final TransaksiStatus status;
  final bool hasMax;
  final int page;

  @override
  List<Object> get props => [error, model, status, hasMax, page];

  @override
  String toString() {
    return 'TransaksiState(error: $error, model: $model, status: $status, hasMax: $hasMax, page: $page)';
  }

  TransaksiState copyWith({
    CustomError? error,
    List<Transaksi>? model,
    TransaksiStatus? status,
    bool? hasMax,
    int? page,
  }) {
    return TransaksiState(
      error: error ?? this.error,
      model: model ?? this.model,
      status: status ?? this.status,
      hasMax: hasMax ?? this.hasMax,
      page: page ?? this.page,
    );
  }
}
