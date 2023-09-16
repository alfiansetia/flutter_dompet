part of 'dompet_bloc.dart';

@freezed
class DompetEvent with _$DompetEvent {
  const factory DompetEvent.started() = _Started;
  const factory DompetEvent.getAll(
      {@Default(2) int limit, @Default(1) int page}) = _GetAll;
  const factory DompetEvent.getDetail(int id) = _GetDetail;
}
