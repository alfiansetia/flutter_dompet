part of 'dompet_form_bloc.dart';

enum DompetFormStatus { inital, loading, loaded, error }

class DompetFormState extends Equatable {
  DompetFormState({
    required this.model,
    required this.status,
    required this.error,
  });

  final CustomError error;
  final Dompet model;
  final DompetFormStatus status;

  factory DompetFormState.initial() => DompetFormState(
        model: Dompet.initial(),
        status: DompetFormStatus.inital,
        error: CustomError(message: ''),
      );

  @override
  List<Object> get props => [error, model, status];

  DompetFormState copyWith({
    CustomError? error,
    Dompet? model,
    DompetFormStatus? status,
  }) {
    return DompetFormState(
      error: error ?? this.error,
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }

  @override
  String toString() =>
      'DompetFormState(error: $error, model: $model, status: $status)';
}
