part of 'login_bloc.dart';

enum LoginStatus {
  initial,
  loading,
  loaded,
  error,
}

class LoginState extends Equatable {
  LoginState({
    required this.error,
    required this.status,
    required this.model,
  });

  factory LoginState.initial() {
    return LoginState(
      status: LoginStatus.initial,
      model: AuthResponseModel.initial(),
      error: const CustomError(),
    );
  }

  final CustomError error;
  final AuthResponseModel model;
  final LoginStatus status;

  @override
  List<Object> get props => [error, status, model];

  @override
  String toString() =>
      'LoginState(error: $error, status: $status, model: $model)';

  LoginState copyWith({
    CustomError? error,
    LoginStatus? status,
    AuthResponseModel? model,
  }) {
    return LoginState(
      error: error ?? this.error,
      status: status ?? this.status,
      model: model ?? this.model,
    );
  }
}
