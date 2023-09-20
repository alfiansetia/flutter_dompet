part of 'transaksi_form_bloc.dart';

enum TransaksiFormStatus { initial, loading, loaded, error }

class TransaksiFormState extends Equatable {
  TransaksiFormState({
    required this.model,
    required this.error,
    required this.status,
  });

  factory TransaksiFormState.initial() => TransaksiFormState(
        model: Transaksi.initial(),
        error: CustomError(message: ''),
        status: TransaksiFormStatus.initial,
      );

  final CustomError error;
  final Transaksi model;
  final TransaksiFormStatus status;

  @override
  List<Object> get props => [model, error, status];

  @override
  String toString() =>
      'TransaksiFormState(error: $error, model: $model, status: $status)';

  TransaksiFormState copyWith({
    CustomError? error,
    Transaksi? model,
    TransaksiFormStatus? status,
  }) {
    return TransaksiFormState(
      error: error ?? this.error,
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }
}
